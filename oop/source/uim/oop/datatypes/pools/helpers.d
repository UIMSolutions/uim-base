/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.datatypes.pools.helpers;

import uim.oop;

mixin(ShowModule!());

@safe:

/**
 * Pool configuration structure.
 */
struct PoolConfig {
  size_t initialCapacity = 10;
  size_t maxCapacity = 100;
  bool threadSafe = false;
  bool enableStatistics = true;
}

/**
 * Pool builder for fluent configuration.
 */
class PoolBuilder(T) {
  private {
    T delegate() @safe _factory;
    PoolConfig _config;
  }

  this(T delegate() @safe factory) {
    _factory = factory;
  }

  /**
   * Set initial capacity.
   */
  PoolBuilder!T initialCapacity(size_t capacity) {
    _config.initialCapacity = capacity;
    return this;
  }

  /**
   * Set maximum capacity.
   */
  PoolBuilder!T maxCapacity(size_t capacity) {
    _config.maxCapacity = capacity;
    return this;
  }

  /**
   * Enable thread-safe mode.
   */
  PoolBuilder!T threadSafe(bool enabled = true) {
    _config.threadSafe = enabled;
    return this;
  }

  /**
   * Enable statistics tracking.
   */
  PoolBuilder!T withStatistics(bool enabled = true) {
    _config.enableStatistics = enabled;
    return this;
  }

  /**
   * Build the object pool.
   */
  IObjectPool!T build() {
    if (_config.threadSafe) {
      return new ThreadSafeObjectPool!T(_factory, _config.initialCapacity, _config.maxCapacity);
    }
    return new ObjectPool!T(_factory, _config.initialCapacity, _config.maxCapacity);
  }

  /**
   * Build a scoped pool.
   */
  auto buildScoped() {
    if (_config.threadSafe) {
      return new ThreadSafeScopedPool!T(_factory, _config.initialCapacity, _config.maxCapacity);
    }
    return new ScopedObjectPool!T(_factory, _config.initialCapacity, _config.maxCapacity);
  }
}

/**
 * Create a pool builder.
 */
PoolBuilder!T poolBuilder(T)(T delegate() @safe factory) {
  return new PoolBuilder!T(factory);
}

/**
 * Global pool registry for sharing pools across the application.
 */
class PoolRegistry {
  private static {
    Object[string] _pools;
  }

  /**
   * Register a pool with a name.
   */
  static void register(T)(string name, IObjectPool!T pool) {
    synchronized {
      _pools[name] = cast(Object)pool;
    }
  }

  /**
   * Get a registered pool by name.
   */
  static IObjectPool!T get(T)(string name) {
    synchronized {
      if (auto pool = name in _pools) {
        return cast(IObjectPool!T)(*pool);
      }
      return null;
    }
  }

  /**
   * Unregister a pool.
   */
  static void unregister(string name) {
    synchronized {
      _pools.remove(name);
    }
  }

  /**
   * Check if a pool is registered.
   */
  static bool has(string name) {
    synchronized {
      return (name in _pools) !is null;
    }
  }

  /**
   * Clear all registered pools.
   */
  static void clear() {
    synchronized {
      _pools.clear();
    }
  }
}

/**
 * Pooled array wrapper for frequently allocated arrays.
 */
class ArrayPool(T) {
  private ObjectPool!(T[]) _pool;

  this(size_t arraySize, size_t initialCapacity = 10, size_t maxCapacity = 50) {
    _pool = new ObjectPool!(T[])(() {
      return new T[arraySize];
    }, initialCapacity, maxCapacity);
  }

  /**
   * Acquire an array from the pool.
   */
  T[] acquire() {
    return _pool.acquire();
  }

  /**
   * Release an array back to the pool.
   */
  void release(T[] array) {
    // Clear array contents before returning to pool
    array[] = T.init;
    _pool.release(array);
  }

  /**
   * Get available arrays count.
   */
  size_t available() {
    return _pool.available();
  }
}

/**
 * Create an array pool.
 */
ArrayPool!T createArrayPool(T)(size_t arraySize, size_t initialCapacity = 10, size_t maxCapacity = 50) {
  return new ArrayPool!T(arraySize, initialCapacity, maxCapacity);
}

// Unit tests
unittest {
  class TestObject {
    int value;
    this() { value = 42; }
  }

  auto pool = poolBuilder(() => new TestObject())
    .initialCapacity(5)
    .maxCapacity(20)
    .build();

  assert(pool !is null);
  auto obj = pool.acquire();
  assert(obj.value == 42);
  pool.release(obj);
}

unittest {
  class TestObject {
    this() {}
  }

  auto pool = poolBuilder(() => new TestObject())
    .threadSafe(true)
    .initialCapacity(10)
    .maxCapacity(50)
    .build();

  assert(pool !is null);
  auto obj = pool.acquire();
  pool.release(obj);
}

unittest {
  class TestObject {
    this() {}
  }

  auto pool = createObjectPool(() => new TestObject(), 5, 10);
  
  PoolRegistry.register("testPool", pool);
  assert(PoolRegistry.has("testPool"));
  
  auto retrieved = PoolRegistry.get!TestObject("testPool");
  assert(retrieved !is null);
  
  PoolRegistry.unregister("testPool");
  assert(!PoolRegistry.has("testPool"));
}

unittest {
  auto arrayPool = createArrayPool!int(10, 5, 20);
  
  auto arr1 = arrayPool.acquire();
  assert(arr1.length == 10);
  
  arr1[0] = 100;
  arrayPool.release(arr1);
  assert(arrayPool.available() == 1);
  
  auto arr2 = arrayPool.acquire();
  assert(arr2[0] == 0); // Should be cleared
}

unittest {
  class TestObject {
    this() {}
  }

  auto scopedPool = poolBuilder(() => new TestObject())
    .initialCapacity(3)
    .maxCapacity(10)
    .buildScoped();

  {
    auto obj = scopedPool.acquireScoped();
    assert(scopedPool.available() == 0);
  }
  
  assert(scopedPool.available() == 1);
}

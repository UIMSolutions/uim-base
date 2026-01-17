/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.patterns.registries.registry;

import uim.oop;

mixin(ShowModule!());

@safe:


/**
 * Basic registry implementation
 */
class Registry(K, V) : IRegistry!(K, V) {
  private V[K] _items;

  void register(K key, V value) {
    _items[key] = value;
  }

  V get(K key) {
    if (auto item = key in _items) {
      return *item;
    }
    throw new Exception("Item not found in registry: " ~ key.to!string);
  }

  V get(K key, V defaultValue) {
    if (auto item = key in _items) {
      return *item;
    }
    return defaultValue;
  }

  bool has(K key) {
    return (key in _items) !is null;
  }

  void unregister(K key) {
    _items.remove(key);
  }

  void clear() {
    _items.clear();
  }

  K[] keys() {
    return _items.keys;
  }

  V[] values() {
    return _items.values;
  }

  size_t count() {
    return _items.length;
  }

  int opApply(scope int delegate(K key, V value) @safe dg) {
    int result = 0;
    foreach (key, value; _items) {
      result = dg(key, value);
      if (result) break;
    }
    return result;
  }
}



/**
 * Typed registry with type-safe registration
 */
class TypedRegistry(Base) {
  private Object[string] _items;
  private TypeInfo[string] _types;

  void register(T : Base)(string key, T instance) {
    _items[key] = cast(Object)instance;
    _types[key] = typeid(T);
  }

  void registerFactory(T : Base)(string key, T delegate() @safe factory) {
    _items[key] = cast(Object)factory;
    _types[key] = typeid(T);
  }

  T get(T : Base)(string key) {
    if (auto item = key in _items) {
      return cast(T)(*item);
    }
    throw new Exception("Item not found: " ~ key);
  }

  bool has(string key) {
    return (key in _items) !is null;
  }

  TypeInfo getType(string key) {
    if (auto type = key in _types) {
      return *type;
    }
    return null;
  }

  void unregister(string key) {
    _items.remove(key);
    _types.remove(key);
  }

  void clear() {
    _items.clear();
    _types.clear();
  }

  string[] keys() {
    return _items.keys;
  }

  size_t count() {
    return _items.length;
  }
}

/**
 * Lazy registry - creates instances on first access
 */
class LazyRegistry(K, V) : IRegistry!(K, V) {
  private V[K] _cache;
  private V delegate() @safe[K] _factories;

  void register(K key, V delegate() @safe factory) {
    _factories[key] = factory;
  }

  void register(K key, V value) {
    _cache[key] = value;
  }

  V get(K key) {
    // Check cache first
    if (auto cached = key in _cache) {
      return *cached;
    }

    // Create and cache
    if (auto factory = key in _factories) {
      auto value = (*factory)();
      _cache[key] = value;
      return value;
    }

    throw new Exception("Item not found in lazy registry: " ~ key.to!string);
  }

  bool has(K key) {
    return (key in _cache) !is null || (key in _factories) !is null;
  }

  bool isCached(K key) {
    return (key in _cache) !is null;
  }

  void unregister(K key) {
    _cache.remove(key);
    _factories.remove(key);
  }

  void clear() {
    _cache.clear();
    _factories.clear();
  }

  void clearCache() {
    _cache.clear();
  }

  K[] keys() {
    import std.algorithm : sort, uniq;
    import std.array : array;
    auto allKeys = _cache.keys ~ _factories.keys;
    return allKeys.sort.uniq.array;
  }

  V[] values() {
    return _cache.values;
  }

  size_t count() {
    return keys().length;
  }
}

/**
 * Hierarchical registry with parent-child relationships
 */
class HierarchicalRegistry(K, V) : IRegistry!(K, V) {
  private V[K] _items;
  private HierarchicalRegistry!(K, V) _parent;

  this(HierarchicalRegistry!(K, V) parent = null) {
    _parent = parent;
  }

  void register(K key, V value) {
    _items[key] = value;
  }

  V get(K key) {
    // Check local registry
    if (auto item = key in _items) {
      return *item;
    }

    // Check parent registry
    if (_parent !is null) {
      return _parent.get(key);
    }

    throw new Exception("Item not found in hierarchical registry: " ~ key.to!string);
  }

  bool has(K key) {
    if ((key in _items) !is null) {
      return true;
    }
    if (_parent !is null) {
      return _parent.has(key);
    }
    return false;
  }

  bool hasLocal(K key) {
    return (key in _items) !is null;
  }

  void unregister(K key) {
    _items.remove(key);
  }

  void clear() {
    _items.clear();
  }

  K[] keys() {
    return _items.keys;
  }

  V[] values() {
    return _items.values;
  }

  size_t count() {
    return _items.length;
  }

  void setParent(HierarchicalRegistry!(K, V) parent) {
    _parent = parent;
  }

  HierarchicalRegistry!(K, V) createChild() {
    return new HierarchicalRegistry!(K, V)(this);
  }
}

/**
 * Thread-safe registry with synchronized access
 */
synchronized class ThreadSafeRegistry(K, V) : IRegistry!(K, V) {
  private V[K] _items;

  void register(K key, V value) {
    synchronized(this) {
      _items[key] = value;
    }
  }

  V get(K key) {
    synchronized(this) {
      if (auto item = key in _items) {
        return *item;
      }
      throw new Exception("Item not found in thread-safe registry: " ~ key.to!string);
    }
  }

  bool has(K key) {
    synchronized(this) {
      return (key in _items) !is null;
    }
  }

  void unregister(K key) {
    synchronized(this) {
      _items.remove(key);
    }
  }

  void clear() {
    synchronized(this) {
      _items.clear();
    }
  }

  K[] keys() {
    synchronized(this) {
      return _items.keys;
    }
  }

  V[] values() {
    synchronized(this) {
      return _items.values;
    }
  }

  size_t count() {
    synchronized(this) {
      return _items.length;
    }
  }
}

// Unit tests
unittest {
  // Test basic registry
  auto registry = new Registry!(string, int);
  
  registry.register("one", 1);
  registry.register("two", 2);
  
  assert(registry.has("one"));
  assert(registry.get("one") == 1);
  assert(registry.count() == 2);
  
  registry.unregister("one");
  assert(!registry.has("one"));
  assert(registry.count() == 1);
  
  registry.clear();
  assert(registry.count() == 0);
}

unittest {
  // Test factory registry
  class Product {
    string name;
    this(string n) { name = n; }
  }
  
  FactoryRegistry!Product.register("productA", () => new Product("A"));
  FactoryRegistry!Product.register("productB", () => new Product("B"));
  
  assert(FactoryRegistry!Product.isRegistered("productA"));
  
  auto productA = FactoryRegistry!Product.create("productA");
  assert(productA.name == "A");
  
  auto productB = FactoryRegistry!Product.create("productB");
  assert(productB.name == "B");
  
  FactoryRegistry!Product.clear();
}

unittest {
  // Test singleton registry
  class Service {
    int value;
    this() { value = 42; }
  }
  
  auto registry = new SingletonRegistry!(string, Service);
  registry.register("service", () => new Service());
  
  auto instance1 = registry.get("service");
  auto instance2 = registry.get("service");
  
  assert(instance1 is instance2); // Same instance
  assert(instance1.value == 42);
}

unittest {
  // Test lazy registry
  int factoryCallCount = 0;
  
  class Resource {
    this() { factoryCallCount++; }
  }
  
  auto registry = new LazyRegistry!(string, Resource);
  registry.register("resource", () => new Resource());
  
  assert(factoryCallCount == 0); // Not created yet
  assert(!registry.isCached("resource"));
  
  auto res1 = registry.get("resource");
  assert(factoryCallCount == 1); // Created on first access
  assert(registry.isCached("resource"));
  
  auto res2 = registry.get("resource");
  assert(factoryCallCount == 1); // Not created again (cached)
  assert(res1 is res2);
}

unittest {
  // Test hierarchical registry
  auto parent = new HierarchicalRegistry!(string, int);
  parent.register("global", 100);
  
  auto child = parent.createChild();
  child.register("local", 200);
  
  assert(child.has("local"));
  assert(child.has("global")); // Inherited from parent
  assert(child.hasLocal("local"));
  assert(!child.hasLocal("global"));
  
  assert(child.get("local") == 200);
  assert(child.get("global") == 100);
}

unittest {
  // Test typed registry
  interface IService {}
  class ServiceA : IService { string name = "A"; }
  class ServiceB : IService { string name = "B"; }
  
  auto registry = new TypedRegistry!IService;
  registry.register("serviceA", new ServiceA());
  registry.register("serviceB", new ServiceB());
  
  auto serviceA = registry.get!ServiceA("serviceA");
  assert(serviceA.name == "A");
  
  auto serviceB = registry.get!ServiceB("serviceB");
  assert(serviceB.name == "B");
}

unittest {
  // Test registry iteration
  auto registry = new Registry!(string, int);
  registry.register("a", 1);
  registry.register("b", 2);
  registry.register("c", 3);
  
  int sum = 0;
  foreach (key, value; registry) {
    sum += value;
  }
  assert(sum == 6);
}

unittest {
  // Test thread-safe registry
  auto registry = new shared ThreadSafeRegistry!(string, int);
  registry.register("key", 42);
  
  assert(registry.has("key"));
  assert(registry.get("key") == 42);
}
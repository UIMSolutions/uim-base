/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.patterns.factories.factory;

import uim.oop;

mixin(ShowModule!());

@safe:

/**
 * Simple factory implementation using a delegate.
 * Supports both direct creation and registry-based creation by key.
 */
class Factory(T : UIMObject) : IFactory!T {
  private T delegate() @safe _defaultCreator;
  protected T delegate()[string] _creators;
  protected T[string] _createObjects;

  this(T delegate() @safe creator) {
    _defaultCreator = creator;
  }

  /**
   * Create an instance using the default creator.
   */
  T create() {
    return _defaultCreator();
  }

  /**
   * Register a creator function for a specific key.
   */
  Factory!T register(string key, T delegate() @safe creator) {
    _creators[key] = creator;
    return this;
  }

  /**
   * Create an instance by key using a registered creator.
   * Throws: Exception if key is not registered
   */
  T create(string key) {
    return isRegistered(key) ? _creators[key]() : null;
  }

  /**
   * Check if a key is registered.
   */
  bool isRegistered(string key) {
    return key in _creators ? true : false;
  }

  /**
   * Unregister a key.
   */
  Factory!T unregister(string key) {
    _creators.remove(key);
    return this;
  }

  /**
   * Clear all registrations.
   */
  Factory!T clearRegistry() {
    _creators.clear();
    return this;
  }

  /**
   * Get all registered keys.
   */
  string[] registeredKeys() {
    return _creators.keys;
  }
}


/**
 * Helper function to create a factory.
 */
Factory!T createFactory(T)(T delegate() @safe creator) {
  return new Factory!T(creator);
}

/**
 * Helper function to create a parameterized factory.
 */
ParameterizedFactory!(T, Args) createParameterizedFactory(T, Args...)(T delegate(Args) @safe creator) {
  return new ParameterizedFactory!(T, Args)(creator);
}

/**
 * Helper function to create a factory builder.
 */
FactoryBuilder!T factoryBuilder(T)(T delegate() @safe creator) {
  return new FactoryBuilder!T(creator);
}

// Unit tests
unittest {
  mixin(ShowTest!"Testing Factory Pattern");

  class Product : UIMObject {
    int value;
    this(int v = 0) { value = v; }
  }

  auto factory = createFactory(() => new Product(42));
  auto product = factory.create();
  assert(product.value == 42);

  auto product2 = factory.create();
  assert(product2 !is product); // Different instances
}

unittest {
  mixin(ShowTest!"Testing Factory with Registry");

  class Product : UIMObject {
    string type;
    int value;
    this(string t, int v) { 
      type = t; 
      value = v; 
    }
  }

  auto factory = createFactory(() => new Product("default", 0));
  
  // Register multiple product creators
  factory.register("small", () => new Product("small", 10));
  factory.register("medium", () => new Product("medium", 50));
  factory.register("large", () => new Product("large", 100));
  
  // Test isRegistered
  assert(factory.isRegistered("small"));
  assert(factory.isRegistered("medium"));
  assert(!factory.isRegistered("extra-large"));
  
  // Test create by key
  auto small = factory.create("small");
  assert(small.type == "small");
  assert(small.value == 10);
  
  auto large = factory.create("large");
  assert(large.type == "large");
  assert(large.value == 100);
  
  // Test registeredKeys
  auto keys = factory.registeredKeys();
  assert(keys.length == 3);
  
  // Test tryCreate
  auto valid = factory.create("medium");
  assert(valid !is null);
  assert(valid.type == "medium");
  
  auto invalid = factory.create("nonexistent");
  assert(invalid is null);
  
  // Test unregister
  factory.unregister("small");
  assert(!factory.isRegistered("small"));
  assert(factory.registeredKeys().length == 2);
  
  // Test clearRegistry
  factory.clearRegistry();
  assert(factory.registeredKeys().length == 0);
  assert(!factory.isRegistered("medium"));  
}

unittest {
  mixin(ShowTest!"Testing Parameterized Factory Pattern");

  class Product : UIMObject {
    int value;
    this(int v) { value = v; }
  }

  auto factory = createParameterizedFactory!Product((int v) => new Product(v));
  auto product = factory.create(100);
  assert(product.value == 100);
}

unittest {
  mixin(ShowTest!"Testing Registry Based Factory Pattern");

  @safe interface IProduct {
    string getName();
  }

  @safe class ProductA : IProduct {
    string getName() { return "ProductA"; }
  }

  @safe class ProductB : IProduct {
    string getName() { return "ProductB"; }
  }

  RegisterBasedFactory!IProduct.register("A", () => cast(Object)new ProductA());
  RegisterBasedFactory!IProduct.register("B", () => cast(Object)new ProductB());

  assert(RegisterBasedFactory!IProduct.isRegistered("A"));
  
  auto productA = RegisterBasedFactory!IProduct.create("A");
  assert(productA.getName() == "ProductA");

  auto productB = RegisterBasedFactory!IProduct.create("B");
  assert(productB.getName() == "ProductB");

  RegisterBasedFactory!IProduct.clear();
}



unittest {
  class Product : UIMObject {
    int value;
    this() { value = 100; }
  }

  auto factory = factoryBuilder(() => new Product())
    .asSingleton()
    .build();

  auto p1 = factory.create();
  auto p2 = factory.create();
  
  assert(p1 is p2); // Same instance due to singleton
}
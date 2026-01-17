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
 */
class Factory(T) : IFactory!T {
  private T delegate() @safe _creator;

  this(T delegate() @safe creator) {
    _creator = creator;
  }

  T create() {
    return _creator();
  }
}

/**
 * Factory with parameters support.
 */
class ParameterizedFactory(T, Args...) {
  private T delegate(Args) @safe _creator;

  this(T delegate(Args) @safe creator) {
    _creator = creator;
  }

  T create(Args args) {
    return _creator(args);
  }
}

/**
 * Abstract factory interface for creating families of related objects.
 */
interface IAbstractFactory {
  Object createProduct(string productType);
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
  class Product {
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
  class Product {
    int value;
    this(int v) { value = v; }
  }

  auto factory = createParameterizedFactory!Product((int v) => new Product(v));
  auto product = factory.create(100);
  assert(product.value == 100);
}

unittest {
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
  class Product {
    int value;
    this() { value = 42; }
  }

  auto singletonFactory = new SingletonFactory!Product(() => new Product());
  
  auto instance1 = singletonFactory.getInstance();
  auto instance2 = singletonFactory.getInstance();
  
  assert(instance1 is instance2); // Same instance
  assert(instance1.value == 42);
}

unittest {
  class Product {
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
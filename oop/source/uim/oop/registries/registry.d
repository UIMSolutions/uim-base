/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.registries.registry;

mixin(Version!"test_uim_oop");

import uim.oop;
@safe:

class DRegistry(T) {
  // #region Singleton
  protected static DRegistry!T _instance;
  public static DRegistry!T instance() {
    return (_instance is null)
      ? _instance = new DRegistry!T : _instance;
  }
  // #endregion Singleton

  protected T[string] _registeredObjects;
  protected T _nullValue = null;
  protected string _pathSeparator = ".";

  size_t size() {
    return _registeredObjects.length;
  }

  // #region path
  // #region has
  mixin(HasMethods!("Paths", "Path", "string[]"));

  bool hasPath(string[] path) {
    return hasKey(pathToKey(path));
  }

  unittest {
    /*     auto registry = new DRegistry!string;
    registry.register("a.b.c", "value");
    assert(registry.hasPath(["a", "b", "c"]));
    assert(!registry.hasPath(["a", "b", "x"]));
 */
  }
  // #endregion has
  // #endregion path

  // #region keys
  // Get all keys in the registry
  string[] keys(SORTORDERS sortorder = NOSORT) {
    auto keys = _registeredObjects.keys;
    if (keys is null) {
      return null;
    }

    if (sortorder == ASCENDING) {
      keys.sort!("a < b");
    } else if (sortorder == DESCENDING) {
      keys.sort!("a > b");
    }

    return keys;
  }

  unittest {
    // Dummy type for registry
    class Dummy {
    }

    auto registry = new DRegistry!Dummy;

    // Register some objects with different keys
    registry.register("b.key", new Dummy);
    registry.register("a.key", new Dummy);
    registry.register("c.key", new Dummy);

    // Test NOSORT
    auto keysNoSort = registry.keys(SORTORDERS.NOSORT);
    assert(keysNoSort.length == 3);
    assert(keysNoSort.canFind("a.key"));
    assert(keysNoSort.canFind("b.key"));
    assert(keysNoSort.canFind("c.key"));

    // Test ASCENDING
    auto keysAsc = registry.keys(SORTORDERS.ASCENDING);
    assert(keysAsc == ["a.key", "b.key", "c.key"]);

    // Test DESCENDING
    auto keysDesc = registry.keys(SORTORDERS.DESCENDING);
    assert(keysDesc == ["c.key", "b.key", "a.key"]);

    // Test empty registry
    auto emptyRegistry = new DRegistry!Dummy;
    auto emptyKeys = emptyRegistry.keys();
    assert(emptyKeys is null || emptyKeys.length == 0);
  }
  // #endregion keys

  // #region keys
  // #region has
  // Check if the key is in the object
  mixin(HasMethods!("Keys", "Key", "string"));

  bool hasKey(string key) {
    return pathToKey(key) in _registeredObjects ? true : false;
  }

  unittest {
    /*     auto registry = new DRegistry!string;
    registry.register("a.b.c", "value");
    assert(registry.hasKey("a.b.c"));
    assert(!registry.hasKey("a.b.x")); */
  }
  // #endregion has

  // #region correct
  string correctPath(string[] path) {
    return pathToKey(path.join(_pathSeparator));
  }

  string pathToKey(string key) {
    return key.strip;
  }
  // #endregion correct
  // #endregion keys

  // #region objects
  T[] objects() {
    return _registeredObjects.values;
  }

  // #region has
  mixin(HasMethods!("Objects", "Object", "T"));

  // TODO
  bool hasObject(T object) {
    foreach (obj; _registeredObjects.values) {
      // if (obj.isEquals(object)) { return true; }
    }
    return false;
  }
  // #endregion has

  // #region get
  T opIndex(string key) {
    return get(key);
  }

  T get(string[] path) {
    return get(pathToKey(path));
  }

  T get(string key) {
    return key in _registeredObjects ? _registeredObjects[key] : _nullValue;
  }
  // #endregion objects

  // #region register
  // Allow assignment via indexing
  void opIndexAssign(string key, T newObject) {
    register(key, newObject);
  }

  // Register an object with a path
  O register(this O)(string[] path, T newObject) {
    this.register(pathToKey(path), newObject);
    return cast(O)this;
  }

  // Register an object with a key
  O register(this O)(string key, T newObject) {
    _registeredObjects[pathToKey(key)] = newObject;
    return cast(O)this;
  }

  unittest {
    // Dummy type for registry
    class Dummy {
      string value;
      this(string v) {
        value = v;
      }

      override bool opEquals(Object o) {
        auto other = cast(Dummy)o;
        return other !is null && value == other.value;
      }
    }

    auto registry = new DRegistry!Dummy;

    // Test register with key
    auto dummy1 = new Dummy("one");
    registry.register("key1", dummy1);
    assert(registry.get("key1") is dummy1);

    // Test register with path
    auto dummy2 = new Dummy("two");
    registry.register(["a", "b", "c"], dummy2);
    assert(registry.get("a.b.c") is dummy2);

    // Test opIndexAssign
    auto dummy3 = new Dummy("three");
    registry["key3"] = dummy3;
    assert(registry.get("key3") is dummy3);

    // Test that keys are registered correctly
    auto keys = registry.keys();
    assert(keys.canFind("key1"));
    assert(keys.canFind("a.b.c"));
    assert(keys.canFind("key3"));

    // Test unregister
    registry.unregister("key1");
    assert(!registry.hasKey("key1"));

    // Test unregister with path
    registry.unregister(["a", "b", "c"]);
    assert(!registry.hasKey("a.b.c"));

    // Test unregisterAll
    registry.unregisterAll();
    assert(registry.size == 0);
  }
  // #endregion register

  // #region unregister
  O unregisterMany(this O)(string[] keys) {
    keys.each!(reg => unregister(reg));
    return cast(O)this;
  }

  O unregister(this O)(string[] path) {
    _registeredObjects.remove(pathToKey(path));
    return cast(O)this;
  }

  O unregister(this O)(string key) {
    _registeredObjects.remove(key);
    return cast(O)this;
  }

  O unregisterAll(this O)() {
    _registeredObjects.clear;
    return cast(O)this;
  }
  // #endregion unregister
}

unittest {
  /* class Test {
    this() {      
    }
    this(string newName) {
      this().name(newName);      
    }
    mixin(TProperty!("string", "name"));
  }

  class TestRegistry : DRegistry!Test {}

  assert(TestRegistry.registry.length == 0);
  assert(TestRegistry.registry.length == 0); */
}

string registryCalls(string className, string instanceName, string typeName) {
  return "
auto "
    ~ instanceName ~ "Registry() { return " ~ className ~ "Registry.instance; }
auto "
    ~ instanceName ~ "Registry(string key, " ~ typeName ~ " registerObject) { 
  return "
    ~ instanceName ~ "Registry.register(key, registerObject); }
auto "
    ~ instanceName ~ "Registry(string[] path) { return " ~ instanceName ~ "Registry.get(path); }
auto "
    ~ instanceName ~ "Registry(string key) { return " ~ instanceName ~ "Registry.get(key); }
";
}

template RegistryCalls(string className, string instanceName, string typeName) {
  const char[] ValidatorCalls = registryCalls(className, instanceName, typeName);
}

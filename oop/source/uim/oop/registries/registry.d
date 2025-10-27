/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.registries.registry;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

class DRegistry(V = UIMObject) : UIMObject, IRegistry!V {
  mixin(RegistryThis!());

  // #region Singleton
  protected static DRegistry!V _instance;
  public static DRegistry!V instance() {
    return (_instance is null)
      ? _instance = new DRegistry!V : _instance;
  }
  // #endregion Singleton

  protected V[string] _registeredObjects;
  protected V _nullValue = null;
  protected string _separator = ".";

  size_t size() {
    return _registeredObjects.length;
  }

  // #region path
  // #region has
  bool hasAllPath(string[][] paths) {
    return paths.all!(path => hasPath(path));
  }

  bool hasAnyPath(string[][] paths) {
    return paths.any!(path => hasPath(path));
  }

  bool hasPath(string[] path) {
    return hasKey(path.toKey(_separator));
  }
  // #endregion has

  // #region get
  T value(string[] path) {
    return value(path.toKey(_separator));
  }
  // #endregion get

  // #region remove
  bool removeAllPath(string[][] paths) {
    return paths.all!(path => removePath(path));
  }

  bool removeAnyPath(string[][] paths) {
    return paths.any!(path => removePath(path));
  }

  bool removePath(string[] path) {
    return removeKey(path.toKey);
  }
  // #endregion remove
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
    auto keysNoSort = registry.keys(NOSORT);
    assert(keysNoSort.length == 3);
    assert(keysNoSort.has("a.key"));
    assert(keysNoSort.has("b.key"));
    assert(keysNoSort.has("c.key"));

    // Test ASCENDING
    auto keysAsc = registry.keys(ASCENDING);
    assert(keysAsc == ["a.key", "b.key", "c.key"]);

    // Test DESCENDING
    auto keysDesc = registry.keys(DESCENDING);
    assert(keysDesc == ["c.key", "b.key", "a.key"]);

    // Test empty registry
    auto emptyRegistry = new DRegistry!Dummy;
    auto emptyKeys = emptyRegistry.keys();
    assert(emptyKeys is null || emptyKeys.length == 0);
  }
  // #endregion keys

  // #region keys
  // #region has
  bool hasAnyKey(string[] keys) {
    return keys.any!(key => hasKey(key));
  }

  bool hasAllKey(string[] keys) {
    return keys.all!(key => hasKey(key));
  }

  bool hasKey(string key) {
    return key.correctKey in _registeredObjects ? true : false;
  }

  unittest {
    /*     auto registry = new DRegistry!string;
    registry.register("a.b.c", "value");
    assert(registry.hasKey("a.b.c"));
    assert(!registry.hasKey("a.b.x")); */
  }
  // #endregion has

  // #region get
  T getKey(string key) {
    auto correctedKey = key.correctKey;
    return correctedKey in _registeredObjects
      ? _registeredObjects[correctedKey]
      : _nullValue;
  }
  // #endregion get

  // #region remove
  bool removeAllKeys(string[] keys) {
    return keys.all!(key => removeKey(key));
  }
  bool removeKey(string key) {
    _registeredObjects.remove(key.correctKey);
    return true;
  }
  // #endregion remove
  // #endregion keys

  // #region register
  // Allow assignment via indexing
  void opIndexAssign(string key, V newObject) {
    register(key, newObject);
  }

  // Register an object with a path
  bool register(string[] path, V newObject) {
    this.register(path.toKey(_separator), newObject);
    return true;
  }

  // Register an object with a key
  bool register(string key, V newObject) {
    _registeredObjects[key.correctKey] = newObject;
    return true;
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
    /* auto dummy1 = new Dummy("one");
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
    assert(keys.has("key1"));
    assert(keys.has("a.b.c"));
    assert(keys.has("key3"));

    // Test unregister
    registry.unregister("key1");
    assert(!registry.hasKey("key1"));

    // Test unregister with path
    registry.unregister(["a", "b", "c"]);
    assert(!registry.hasKey("a.b.c"));

    // Test unregisterAll
    registry.unregisterAll();
    assert(registry.size == 0); */
  }
  // #endregion register

  // #region unregister
  bool unregisterAll() {
    _registeredObjects.clear();
    return true;
  }

  bool unregisterMany(string[][] paths) {
    paths.each!(path => unregister(path));
    return true;
  }

  bool unregisterMany(string[] keys) {
    keys.each!(key => unregister(key));
    return true;
  }

  bool unregister(string[] path) {
    _registeredObjects.remove(path.toKey(_separator));
    return true;
  }

  bool unregister(string key) {
    _registeredObjects.remove(key);
    return true;
  }
  // #endregion unregister
}

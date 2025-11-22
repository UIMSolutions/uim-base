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

  // #region IObject
  // Get the name of the object.
  override string name() {
    return super.name;
  }

  // Get or set the name of the object.
  override void name(string newName) {
    super.name(newName);
  }

  // Compares two IObject instances for equality based on their names.
  override bool isEqual(IObject other) {
    if (other is null) {
      return false;
    }
    if (this is other) {
      return true;
    }
    if (this.classinfo !is other.classinfo) {
      return false;
    }
    if (this.name is null && other.name is null) {
      return true;
    }
    if (this.name is null || other.name is null) {
      return false;
    }
    return this.name == other.name;
    // TODO: Consider adding more properties for comparison if needed.
  }

  // Returns a string representation comparing two IObject instances.
  override string toString() {
    return "DRegistry: " ~ this.name;
  }

  // Creates a clone of the current object.
  override IObject clone() {
    auto registry = new DRegistry!V;
    registry.name(this.name);
    /* 
    _registeredObjects.each!(
      (key, obj) => registry.setKey(key, obj)
    ); */
    return registry;
  }
  // #endregion IObject

  override bool opEquals(Object o) const {
    auto other = cast(DRegistry!V)o;
    if (other is null) {
      return false;
    }

    if (this.size != other.size) {
      return false;
    }

    // auto keys = this._registeredObjects.keys;    

    foreach (key; this._registeredObjects.keys) {
      if (!other._registeredObjects.hasKey(key) ||
          this._registeredObjects[key] !is other._registeredObjects[key]) {
        return false;
      }
    }

    return true;
  }

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
  // #region hasAllPath
  bool hasAllPath(string[][] paths) {
    return paths.all!(path => hasPath(path));
  }
  // #endregion hasAllPath

  // #region hasAnyPath
  bool hasAnyPath(string[][] paths) {
    return paths.any!(path => hasPath(path));
  }
  // #endregion hasAnyPath

  // #region hasPath
  bool hasPath(string[] path) {
    return hasKey(path.toKey(_separator));
  }
  // #endregion hasPath
  // #endregion has

  // #region get
  // #region values
  V[] values(string[][] paths) {
    return paths.map!(path => value(path)).array;
  }
  // #endregion values

  // #region value
  V value(string[] path) {
    return value(path.toKey(_separator));
  }
  // #endregion value
  // #endregion get

  // #region remove
  // #region removeAllPath
  bool removeAllPath(string[][] paths) {
    return paths.all!(path => removePath(path));
  }
  // #endregion removeAllPath

  // #region removeAnyPath
  bool removeAnyPath(string[][] paths) {
    return paths.any!(path => removePath(path));
  }
  // #endregion removeAnyPath

  // #region removePath
  bool removePath(string[] path) {
    return removeKey(path.toKey);
  }
  // #endregion removePath
  // #endregion remove

  // #region register
  // Register an object with a path
  bool register(string[] path, V newObject) {
    this.register(path.toKey(_separator), newObject);
    return true;
  }
  // #endregion register

  // #region unregister
  // #region unregisterAll
  bool unregisterAll(string[][] paths) {
    return paths.all!(path => unregister(path));
  }
  // #endregion unregisterAll

  // #region unregisterAny
  bool unregisterAny(string[][] paths) {
    return paths.any!(path => unregister(path));
  }
  // #endregion unregisterAny

  // #region unregister
  bool unregister(string[] path) {
    return unregister(path.toKey(_separator));
  }
  // #endregion unregister
  // #endregion unregister
  // #endregion path

  // #region keys
  // #region has
  // #region hasAllKey
  bool hasAllKey(string[] keys) {
    return keys.all!(key => hasKey(key));
  }
  // #endregion hasAllKey

  // #region hasAnyKey
  bool hasAnyKey(string[] keys) {
    return keys.any!(key => hasKey(key));
  }
  // #endregion hasAnyKey

  // #region hasKey
  bool hasKey(string key) {
    return key.correctKey in _registeredObjects ? true : false;
  }
  // #endregion hasKey
  // #endregion has

  // #region keys
  // Get all keys in the registry
  string[] keys() {
    auto keys = _registeredObjects.keys;

    return keys is null ? null : keys;
  }
  ///
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

  // #region get
  // #region values
  V[] values() {
    return _registeredObjects.values;
  }
  // #endregion values

  // #region values
  V[] values(string[] keys) {
    return keys.map!(key => value(key)).array;
  }
  // #endregion values

  // #region value
  V value(string key) {
    auto correctedKey = key.correctKey;
    return correctedKey in _registeredObjects
      ? _registeredObjects[correctedKey] : _nullValue;
  }
  // #endregion value
  // #endregion get

  // #region remove
  // #region removeAllKey
  bool removeAllKey(string[] keys) {
    return keys.all!(key => removeKey(key));
  }
  // #endregion removeAllKey

  // #region removeAnyKey
  bool removeAnyKey(string[] keys) {
    return keys.any!(key => removeKey(key));
  }
  // #endregion removeAnyKey

  // #region removeKey
  bool removeKey(string key) {
    _registeredObjects.remove(key.correctKey);
    return true;
  }
  // #endregion removeKey
  // #endregion remove
  // #endregion keys

  // #region opIndexAssign
  // Allow assignment via indexing
  void opIndexAssign(string key, V newObject) {
    register(key, newObject);
  }
  // #endregion opIndexAssign

  // #region register 
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
  // #region unregisterAll
  bool unregisterAll() {
    _registeredObjects.clear();
    return true;
  }
  // #endregion unregisterAll

  // #region unregisterAll
  bool unregisterAll(string[] keys) {
    return keys.all!(key => unregister(key));
  }
  // #endregion unregisterAll

  // #region unregisterAny
  bool unregisterAny(string[] keys) {
    return keys.any!(key => unregister(key));
  }
  // #endregion unregisterAny

  // #region unregister
  bool unregister(string key) {
    _registeredObjects.remove(key);
    return true;
  }
  // #endregion unregister
  // #endregion unregister
}

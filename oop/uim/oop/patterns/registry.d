/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.patterns.registry;

import uim.oop;

@safe:

version (test_uim_oop) {
  unittest {
    writeln("-----  ", __MODULE__, "\t  -----");
  }
}
class DObjectRegistry(T : UIMObject) {
  // #region Singleton
  protected static DObjectRegistry!T _registration;
  public static DObjectRegistry!T registration() {
    return (_registration is null)
      ? _registration = new DObjectRegistry!T : _registration;
  }
  // #endregion Singleton

  protected T[string] _objects;
  protected T _nullValue = null;
  protected string _pathSeparator = ".";

  size_t length() {
    return _objects.length;
  }

  // #region keys

  string[] keys(SORTORDERS sortorder = NOSORT) {
    auto keys = _objects.keys;
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

  // #region has
  mixin(HasMethods!("Paths", "Path", "string[]"));

  bool hasPath(string[] path) {
    return hasKey(correctKey(path));
  }
  unittest {
    auto registry = new DObjectRegistry!string;
    registry.register("a.b.c", "value");
    assert(registry.hasPath(["a", "b", "c"]));
    assert(!registry.hasPath(["a", "b", "x"]));
  }
  // #endregion has

  // #region keys
  // #region has
  // Check if the key is in the object
  mixin(HasMethods!("Keys", "Key", "string"));

  bool hasKey(string key) {
    return correctKey(key) in _objects ? true : false;
  }
  unittest {
    auto registry = new DObjectRegistry!string;
    registry.register("a.b.c", "value");
    assert(registry.hasKey("a.b.c"));
    assert(!registry.hasKey("a.b.x"));
  }
  // #endregion has

  // #region correct
  string correctKey(string[] path) {
    return correctKey(path.join(_pathSeparator));
  }

  string correctKey(string key) {
    return key.strip;
  }
  // #endregion correct
  // #endregion keys

  // #region objects
  T[] objects() {
    return _objects.values;
  }

  // #region has
  mixin(HasMethods!("Objects", "Object", "T"));

  // TODO
  bool hasObject(T object) {
    foreach (obj; _objects.values) {
      // if (obj.isEquals(object)) { return true; }
    }
    return false;
  }
  // #endregion has

  T get(string[] path) {
    return get(correctKey(path));
  }

  T opIndex(string key) {
    return get(key);
  }

  T get(string key) {
    return correctKey(key) in _objects ? _objects[correctKey(key)] : _nullValue;
  }
  // #endregion objects

  /// Get registeredobject by index

  // #region register
  void opIndexAssign(string key, T newObject) {
    register(key, newObject);
  }

  O register(this O)(T newObject) {
    this.register(newObject.classname, newObject);
    return cast(O) this;
  }

  O register(this O)(string[] path, T newObject) {
    this.register(correctKey(path), newObject);
    return cast(O) this;
  }

  O register(this O)(string key, T newObject) {
    _objects[correctKey(key)] = newObject;
    return cast(O) this;
  }
  // #endregion register

  // #region clone
  T create(string[] path) {
    return create(correctKey(path));
  }

  T create(string key) {
    T createdObject;
    if (auto registerdObject = get(correctKey(key))) {
      () @trusted { createdObject = cast(T) factory(registerdObject.classname); }();
    }
    return createdObject;
  }
  // #endregion clone

  // #region remove
  O removeKeys(this O)(string[] keys) {
    keys.all!(reg => removeKey(reg));
    return cast(O) this;
  }

  O removeKey(this O)(string key) {
    _objects.removeKey(key);
    return cast(O) this;
  }

  O removeKey(this O)(string key) {
    _objects.removeKey(key);
    return cast(O) this;
  }

  O clearAll(this O)() {
    _objects = null;
    return cast(O) this;
  }
  // #endregion remove

  // Create the registeredobject object with the correct settings.
  /* 
    T create(string registration, Json[string] initData = null) {
        return hasRegistration(registration) 
      ? registeredobjects(registration).clone(initData)
      : null;
    } */

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

  class TestRegistry : DObjectRegistry!Test {}

  assert(TestRegistry.registry.length == 0);
  assert(TestRegistry.registry.length == 0); */
}

/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.patterns.factory;

mixin(Version!"test_uim_oop");

import uim.oop;
@safe:


class DFactory(T) : UIMObject, IKeyAndPath {
  this() {
    super();
  }

  this(Json[string] initData) {
    super(initData);
  }

  this(string newName, Json[string] initData = null) {
    super(newName, initData);
  }

  override bool initialize(Json[string] initData = null) {
    if (!super.initialize(initData)) {
      return true;
    }

    name("Attribute");

    return true;
  }

  protected static DFactory!T _factory;
  protected T delegate(Json[string] options = null)[string] _workers;
  public static DFactory!T factory() {
    if (_factory is null) {
      _factory = new DFactory!T;
    }
    return _factory;
  }

  protected string _pathSeparator = ".";

  // #region paths
  string[][] paths() {
    return _workers.keys.map!(key => key.split(_pathSeparator)).array;
  }

  mixin(HasMethods!("Paths", "Path", "string[]"));
  
  bool hasPath(string[] path) {
    return hasKey(path.join(_pathSeparator));
  }
  // #endregion paths

  // #region keys
  string[] keys(SORTORDERS sortorder = NOSORT) {
    auto keys = _workers.keys;
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
  mixin(HasMethods!("Keys", "Key", "string"));

  bool hasKey(string key) {
    return key in _workers ? true : false;
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

  void set(string workerName, T delegate(Json[string] options = null) @safe workFunc) {
    _workers[workerName] = workFunc;
  }

  T path(string[] path, Json[string] options = null) @safe {
    return create(correctKey(path), options);
  }

  T create(string key, Json[string] options = null) @safe {
    return correctKey(key) in _workers
      ? _workers[correctKey(key)](options) : null;
  }

  T opIndex(string key, Json[string] options = null) {
    return create(key, options);
  }

  // #region remove
  bool removePaths(string[][] paths) {
    return paths.all!(path => removePath(path));
  }

  bool removePath(string[] path) {
    return removeKey(correctKey(path));
  }

  bool removeKeys(string[] keys) {
    return keys.all!(key => removeKey(key));
  }

  bool removeKey(string key) {
    return removeKey(correctKey(key));
  }

  void clear() {
    _workers = null;
  }
  // #endregion remove
}

unittest {
  /* class Test : UIMObject {
        this() {
            this.name("Test");
        }
        this(string name) {
            this().name(name);
        }
    }

    class TestFactory : DFactory!Test {}
    auto Factory() { return TestFactory.instance; }

    Factory.set("testWorkerOne", (Json[string] options = null) @safe {
        return new Test("one");
    });
        return new Test("two");
    }    Factory.set("testWorker.two", (Json[string] options = null) @safe {        
        return new Test("two");
    });
    Factory.set("testWorker.and.three", (Json[string] options = null) @safe {        
        return new Test("three");
    });

    assert(Factory.create("testWorkerOne").name == "one");
    assert(Factory.path(["testWorker", "two"]).name == "two");
    assert(Factory.create("testWorker.two").name == "two");
    assert(Factory.path(["testWorker", "and", "three"]).name == "three");
    assert(Factory.create("testWorker.and.three").name == "three");

    assert(Factory.hasPath(["testWorkerOne"]));
    assert(Factory.hasKey("testWorkerOne"));

    assert(Factory.hasPath(["testWorker", "two"]));
    assert(Factory.hasKey("testWorker.two"));

    assert(Factory.hasPath(["testWorker", "and", "three"]));
    assert(Factory.hasKey("testWorker.and.three"));

    assert(Factory.hasAnyPaths([["testWorker", "two"], ["unknown"]]));
    assert(Factory.hasAllPaths([["testWorker", "two"], ["testWorker", "and", "three"]]));

    assert(Factory.hasAnyKeys(["testWorker.two", "unknown"]));
    assert(Factory.hasAllKeys(["testWorker.two", "testWorkerOne"])); 
    */
}

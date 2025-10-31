/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.factories.factory;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

class DFactory(V = UIMObject) : UIMObject, IFactory!V {
  mixin(FactoryThis!());

  protected static DFactory!V _instance;
  protected V delegate(Json[string] options = null)[string] _workers;
  public static DFactory!V instance() {
    if (_instance is null) {
      _instance = new DFactory!V;
    }
    return _instance;
  }

  override bool initialize(Json[string] initData = null) {
    if (!super.initialize(initData)) {
      return false;
    }

    if (initData.hasKey("separator")) {
      _separator = initData.getstring("separator");
    }

    return true;
  }

  protected string _separator = ".";

  // #region paths 
  string[][] paths() {
    if (_workers is null) {
      return null;
    }

    string[][] foundPaths;
    foreach (key; this.keys) {
      if (key is null) {
        continue;
      }
      foundPaths ~= key.toPath(_separator);
    }

    return foundPaths;
  }

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

  // #region set
  // Sets a specific item in the collection.
  bool setPath(string[] path, V delegate(Json[string] options = null) @safe createFunc) {
    return setKey(path.toKey, createFunc);
  }
  // #endregion set

  // #region update
  // Updates a specific item in the collection.
  bool updatePath(string[] path, V delegate(Json[string] options = null) @safe createFunc) {
    return updateKey(path.toKey, createFunc);
  }
  // #endregion update

  // #region merge
  // Merges a specific item into the collection.
  bool mergePath(string[] path, V delegate(Json[string] options = null) @safe createFunc) {
    return mergeKey(path.toKey, createFunc);
  }
  // #endregion merge

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

  // #endregion paths

  // #region keys
  string[] keys() {
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
  // Checks if all of the specified keys exist in the collection.
  bool hasAllKey(string[] keys) {
    return keys.all!(key => hasKey(key));
  }

  // Checks if any of the specified keys exist in the collection.
  bool hasAnyKey(string[] keys) {
    return keys.any!(key => hasKey(key));
  }

  // Checks if a specific key exists in the collection.
  bool hasKey(string key) {
    return key in _workers ? true : false;
  }
  // #endregion has

  // #region set
  // Sets the entire collection to the specified items.
  bool setKey(string key, V delegate(Json[string] options = null) @safe createFunc) {
    _workers[key] = createFunc;
    return true;
  }
  ///
  unittest {
    // Create a factory specialized for string keys and TestProduct values.
    auto factory = new DFactory!TestProduct;

    // Flag to ensure the delegate is actually invoked.
    bool invoked = false;

    // Delegate matching the factory's expected signature.
    TestProduct delegate(Json[string] options = null) @safe createDelegate = (
      Json[string] options = null) @safe {
      invoked = true;
      return new TestProduct("created");
    };

    // setKey should store the delegate and return true.
    assert(factory.setKey("key1", createDelegate) == true);

    // create should invoke the stored delegate and return the produced object.
    auto produced = factory.create("key1");
    assert(produced !is null);
    assert(invoked == true);
    assert(cast(TestProduct)produced.id == "created");
  }
  // #endregion set

  // #region update
  // Updates a specific item in the collection.
  bool updateKey(string key, V delegate(Json[string] options = null) @safe createFunc) {
    return hasKey(key) ? setKey(key, createFunc) : false;
  }
  // #endregion update

  // #region merge
  // Merges a specific item into the collection.
  bool mergeKey(string key, V delegate(Json[string] options = null) @safe createFunc) {
    return !hasKey(key) ? setKey(key, createFunc) : false;
  }
  // #endregion merge

  // #region remove
  bool removeAllKey(string[] keys) {
    return keys.all!(key => removeKey(key));
  }

  bool removeAnyKey(string[] keys) {
    return keys.any!(key => removeKey(key));
  }

  bool removeKey(string key) {
    remove(key.correctKey);
    return true;
  }
  // #endregion remove
  // #endregion keys

  // #region create
  // #region path
  V[string] createMany(string[][] paths, Json[string] options = null) {
    V[string] result;
    foreach (path; paths) {
      result[path.toKey] = create(path, options);
    }
    return result;
  }

  V create(string[] path, Json[string] options = null) @safe {
    return create(path.toKey);
  }
  // #endregion path

  // #region key
  V[string] createMany(string[] keys, Json[string] options = null) {
    V[string] result;
    keys.each!(key => result[key] = create(key, options));
    return result;
  }

  V opIndex(string[] key, Json[string] options = null) {
    return create(key, options);
  }

  V create(string key, Json[string] options = null) @safe {
    V result;
    return key.correctKey in _workers
      ? _workers[key.correctKey](options) : result;
  }
  // #endregion key
  // #endregion create
}

/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.factories.factory;

mixin(Version!"test_uim_oop");

import uim.oop;

@safe:

class DFactory(T) : UIMObject, IFactory!T {
  mixin(FactoryThis!());

  protected static DFactory!T _instance;
  protected T delegate(Json[string] options = null)[string] _workers;
  public static DFactory!T instance() {
    if (_instance is null) {
      _instance = new DFactory!T;
    }
    return _instance;
  }

  protected string _separator = ".";

  // #region paths 
  string[][] paths() {
    return _workers.keys.map!(key => key.keyToPath(_separator)).array;
  }

  // #region has
  bool hasAnyPath(string[][] paths) {
    return paths.any!(path => hasPath(path));
  }

  bool hasAllPath(string[][] paths) {
    return paths.all!(path => hasPath(path));
  }

  bool hasPath(string[] path) {
    return has(path.join(_separator));
  }
  // #endregion has

  // #region set
  // Sets a specific item in the collection.
  bool setPath(string[] path, T delegate(Json[string] options = null) @safe createFunc) {
    return setKey(path.toKey, createFunc);
  }
  // #endregion set

  // #region update
  // Updates a specific item in the collection.
  bool updatePath(string[] path, T delegate(Json[string] options = null) @safe createFunc) {
    return updateKey(path.toKey, createFunc);
  }
  // #endregion update

  // #region merge
  // Merges a specific item into the collection.
  bool mergePath(string[] path, T delegate(Json[string] options = null) @safe createFunc) {
    return mergeKey(path.toKey, createFunc);
  }
  // #endregion merge

  // #region remove
  bool removePaths(string[][] paths) {
    return paths.all!(path => remove(path));
  }

  bool removePath(string[] path) {
    return remove(path.toKey);
  }
  // #endregion remove

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
  bool hasAnyKey(string[] keys) {
    return keys.any!(key => hasKey(key));
  }

  bool hasAllKey(string[] keys) {
    return keys.all!(key => hasKey(key));
  }

  bool hasKey(string key) {
    return key in _workers ? true : false;
  }
  // #endregion has

  // #region set
  // Sets the entire collection to the specified items.
  bool setKey(string workerName, T delegate(Json[string] options = null) @safe createFunc) {
    _workers[workerName] = createFunc;
    return true;
  }
  // #endregion set

  // #region update
  // Updates a specific item in the collection.
  bool updateKey(string key, T delegate(Json[string] options = null) @safe createFunc) {
    return hasKey(key) ? setKey(key, item) : false;
  }
  // #endregion update

  // #region merge
  // Merges a specific item into the collection.
  bool mergeKey(string key, T delegate(Json[string] options = null) @safe createFunc) {
    return !hasKey(key) ? setKey(key, item) : false;
  }
  // #endregion merge

  // #region remove
  bool removeAll() {
    return _workers.clear;
  }

  bool removeKeys(string[] keys) {
    return keys.all!(key => removeKey(key));
  }

  bool removeKey(string key) {
    return remove(key.correctKey) ? false : true;
  }
  // #endregion remove
  // #endregion keys

  // #region create
  // #region path
  T[string] createMany(string[][] paths, Json[string] options = null) {
    T[string] result;
    paths.each!(path => result[path] = create(path, options));
    return result;
  }

  T create(string[] path, Json[string] options = null) @safe {
    return has(path) ? _workers[path.toKey](options) : null;
  }
  // #endregion path

  // #region key
  T[string] createMany(string[] keys, Json[string] options = null) {
    T[string] result;
    keys.each!(key => result[key] = create(key, options));
    return result;
  }

  T opIndex(string key, Json[string] options = null) {
    return create(key, options);
  }

  T create(string key, Json[string] options = null) @safe {
    T result;
    return pathToKey(key) in _workers
      ? _workers[pathToKey(key)](options) : result;
  }
  // #endregion key
  // #endregion create
}

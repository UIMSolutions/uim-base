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
  bool hasAnyPaths(string[][] paths) {
    return paths.any!(path => hasPath(path));
  }

  bool hasAllPaths(string[][] paths) {
    return paths.all!(path => hasPath(path));
  }

  bool hasPath(string[] path) {
    return hasKey(path.join(_separator));
  }
  // #endregion has

  // #region get
  // Gets the entire collection as a map of paths to items.
  T[string[]] items(string[][] paths);

  // Gets a specific item from the collection.
  T item(string[] path);
  // #endregion get

  // #region set
  // Sets the entire collection to the specified items.
  bool setPath(T[string[]] items) {
    return items.byKeyValue.all!((k, v) => setPath(k, v));
  }

  // Sets a specific item in the collection.
  bool setPath(string[] path, T item) {
    return set(path.toKey, item);
  }
  // #endregion set

  // #region update
  // Updates the entire collection to the specified items.
  bool updatePath(T[string[]] items) {
    return items.byKeyValue.all!((k, v) => updatePath(k, v));
  }

  // Updates a specific item in the collection.
  bool updatePath(string[] path, T item) {
    return update(path.toKey, item);
  }
  // #endregion update

  // #region merge
  // Merges the entire collection with the specified items.
  bool mergePath(T[string[]] items) {
    return items.byKeyValue.all!((k, v) => mergePath(k, v));
  }

  // Merges a specific item into the collection.
  bool mergePath(string[] path, T item) {
    return merge(path.toKey, item);
  }
  // #endregion merge

  // #region remove
  bool removePaths(string[][] paths) {
    return paths.all!(path => removePath(path));
  }

  bool removePath(string[] path) {
    return removeKey(path.toKey);
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

  bool hasAnyKeys(string[] keys) {
    return keys.any!(key => hasKey(key));
  }

  bool hasAllKeys(string[] keys) {
    return keys.all!(key => hasKey(key));
  }

  bool hasKey(string key) {
    return key in _workers ? true : false;
  }

  // #region set
  // Sets the entire collection to the specified items.
  bool set(T[string[]] items) {
    return items.byKeyValue.all!((k, v) => set(k, v));
  }

  // Sets a specific item in the collection.
  bool set(string key, T item) {
    return set(path.toKey, item);
  }

  // #endregion keys

  void set(string workerName, T delegate(Json[string] options = null) @safe workFunc) {
    _workers[workerName] = workFunc;
  }
  // #endregion set

  // #region update
  // Updates the entire collection to the specified items.
  bool update(T[string[]] items) {
    return items.byKeyValue.all!((k, v) => update(k, v));
  }

  // Updates a specific item in the collection.
  bool update(string key, T item) {
    return hasKey(key) ? set(key, item) : false;
  }
  // #endregion update

  // #region merge
  // Merges the entire collection with the specified items.
  bool merge(T[string[]] items) {
    return items.byKeyValue.all!((k, v) => merge(k, v));
  }

  // Merges a specific item into the collection.
  bool merge(string key, T item) {
    return !hasKey(key) ? set(key, item) : false;
  }
  // #endregion merge

  // #region remove
  bool removeAll() {
    return _workers.clear;
  }

  bool remove(string[] keys) {
    return keys.all!(key => removeKey(key));
  }

  bool removeKey(string key) {
    return remove(key.correctKey) ? false : true;
  }
  // #endregion remove
  // #endregion keys

  // #region create
  T create(string[] path, Json[string] options = null) @safe {
    return has(path) ? _workers[path.toKey](options) : null;
  }

  T opIndex(string key, Json[string] options = null) {
    return create(key, options);
  }

  T create(string key, Json[string] options = null) @safe {
    T result;
    return pathToKey(key) in _workers
      ? _workers[pathToKey(key)](options) : result;
  }
  // #endregion create
}

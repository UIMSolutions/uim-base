/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.collections.collection;

import uim.oop;

mixin(Version!"test_uim_oop");
@safe:

class DCollection(T) : UIMObject, ICollection!T {
  mixin(CollectionThis!());

  protected string _pathSeparator = ".";
  protected T[string] _items;

  T[string] items() {
    return _items.dup;
  }
  
  size_t size() {
    return _items.length;
  }

  // #region paths
  string[][] paths(SORTORDERS sortorder = NOSORT) {
    // TODO: Implement sorting for paths
    return _items.keys.map!(key => key.split(_pathSeparator)).array;
  }

  // #region has
  bool hasAllPath(string[][] paths) {
    return paths.all!(path => hasPath(path));
  }

  bool hasAnyPath(string[][] paths) {
    return paths.any!(path => hasPath(path));
  }

  bool hasPath(string[] path) {
    return hasKey(path.join(_pathSeparator));
  }
  // #endregion has
  
  // #region get
    // Gets the entire collection as a map of paths to items.
  T[string] itemsByPath(string[][] paths) {
    T[string] foundItems;
    paths
      .map!(path => path.toKey)
      .filter!(key => hasKey(key))
      .each!(key => foundItems[key] = itemByKey(key));

    return foundItems;
  }

  // Gets a specific item from the collection.
  T itemByPath(string[] path) {
    return itemByKey(path.toKey);
  }
  // #endregion get

  // #region set
  // Sets the entire collection to the specified item.
  bool setPaths(string[][] paths, T item) {
    return paths.all!(p => setPath(p, item));
  }

  // Sets a specific item in the collection.
  bool setPath(string[] path, T item) {
    return setKey(path.toKey, item);
  }
  // #endregion set

  // #region update
  // Updates the entire collection to the specified item.
  bool updatePaths(string[][] paths, T item) {
    return paths.all!(p => updatePath(p, item));
  }

  // Updates a specific item in the collection.
  bool updatePath(string[] path, T item) {
    return updateKey(path.toKey, item);
  }
  // #endregion update

  // #region merge
  // Merges the entire collection with the specified item.
  bool mergePaths(string[][] paths, T item) {
    return paths.all!(p => mergePath(p, item));
  }

  // Merges a specific item into the collection.
  bool mergePath(string[] path, T item) {
    return mergeKey(path.toKey, item);
  }
  // #endregion merge

  // #region remove
  bool removePaths(string[][] paths) {
    return paths.all!(path => removePath(path));
  }

  bool removePath(string[] path) {
    return removeKey(path.toKey);
  }

  unittest {
    auto collection = new DCollection!string;

    // Add items with hierarchical keys
    collection.setKey("a.b.c", "value1");
    collection.setKey("x.y", "value2");
    collection.setKey("single", "value3");

    // Remove multiple paths
    string[][] pathsToRemove = [
      ["a", "b", "c"],
      ["x", "y"]
    ];

    assert(collection.hasPath(["a", "b", "c"]));
    assert(collection.hasPath(["x", "y"]));
    assert(collection.hasPath(["single"]));

    bool removed = collection.removePaths(pathsToRemove);
    assert(removed);

    // Check that removed paths are gone
    assert(!collection.hasPath(["a", "b", "c"]));
    assert(!collection.hasPath(["x", "y"]));
    assert(collection.hasPath(["single"]));

    // Remove single path
    assert(collection.removePath(["single"]));
    assert(!collection.hasPath(["single"]));

    // Try removing non-existent path
    assert(collection.removePath(["not", "exist"])); // Should not throw, returns true/false depending on implementation
  }
  // #endregion remove
  // #endregion paths

  // #region keys
  string[] keys(SORTORDERS sortorder = NOSORT) {
    auto keys = _items.keys;
    if (_items is null) {
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
  bool hasAllKey(string[] keys) {
    return keys.all!(key => hasKey(key));
  }

  bool hasAnyKey(string[] keys) {
    return keys.any!(key => hasKey(key));
  }

  bool hasKey(string key) {
    return key in _items ? true : false;
  }
  // #endregion has

  // #region get
  // Gets the entire collection as a map of paths to items.
  T[string] itemsByKey(in string[] keys) {
    T[string] foundItems;
    auto ks = keys.map!(k => k.correctKey).array;
    ks = ks.filter!(k => k in _items ? true : false).array;
    ks.each!(k => foundItems[k] = itemByKey(k));

    return foundItems;
  }

  // Gets a specific item from the collection.
  T itemByKey(string key) {
    return key in _items ? _items[key.correctKey] : null;
  }
  // #endregion get

  // #region set
  // Sets the entire collection to the specified items.
  bool setKeys(T[string] items) {
    foreach(k, v; _items) {
      if (!setKey(k, v)) return false;
    }
    return true;
  }

  bool setKeys(string[] keys, T item) {
    return keys.all!(key => setKey(key, item));
  }

  void opIndexAssign(string key, T item) {
    setKey(key, item);
  }

  // Sets a specific item in the collection.
  bool setKey(string key, T item) {
    _items[key.correctKey] = item;
    return true;
  }
  // #endregion set

  // #region update
  // Updates the entire collection to the specified items.
  bool updateKeys(T[string] items) {
    foreach(k, v; items) {
      if (!updateKey(k, v)) return false;
    }
    return true;
  }

  bool updateKeys(string[] keys, T item) {
    return keys.all!(key => updateKey(key, item));
  }

  // Updates a specific item in the collection.
  bool updateKey(string key, T item) {
    return (hasKey(key)) ? setKey(key, item) : false;
  }
  // #endregion update

  // #region merge
  // Merges the entire collection with the specified items.
  bool mergeKeys(T[string] items) {
    foreach(k, v; items) {
      if (!mergeKey(k, v)) return false;
    }
    return true;
  }

  bool mergeKeys(string[] keys, T item) {
    return keys.all!(key => mergeKey(key, item));
  }

  // Merges a specific item into the collection.
  bool mergeKey(string key, T item) {
    return (!hasKey(key)) ? setKey(key, item) : false;
  }
  // #endregion merge

  // #region remove
  bool removeAll() {
    _items.clear();
    return true;
  }

  bool removeKeys(string[] keys) {
    return keys.all!(key => removeKey(key));
  }

  bool removeKey(string key) {
    remove(key.correctKey);
    return true;
  }
  // #endregion remove
  // #endregion keys
}

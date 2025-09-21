/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.collections.collection;

mixin(Version!"test_uim_oop");

import uim.oop;

@safe:

class DCollection(T) : UIMObject, ICollection!T {
  mixin(CollectionThis!());

  protected string _pathSeparator = ".";
  protected T[string] _items;

  size_t count() {
    return _items.length;
  }

  // #region paths
  string[][] paths() {
    return _items.keys.map!(key => key.split(_pathSeparator)).array;
  }

  bool hasAllPaths(string[][] paths) {
    return paths.all!(path => hasPath(path));
  }

  bool hasAnyPath(string[][] paths) {
    return paths.any!(path => hasPath(path));
  }

  bool hasPath(string[] path) {
    return has(path.join(_pathSeparator));
  }

  unittest {
    auto collection = new DCollection!string;

    // Add items with hierarchical keys
    collection.set("a.b.c", "value1");
    collection.set("x.y", "value2");
    collection.set("single", "value3");

    // Test paths()
    auto expectedPaths = [
      ["a", "b", "c"],
      ["x", "y"],
      ["single"]
    ];
    auto actualPaths = collection.paths();
    assert(actualPaths.length == expectedPaths.length);
    foreach (i, path) {
      assert(path == expectedPaths[i]);
    }

    // Test hasPath
    assert(collection.hasPath(["a", "b", "c"]));
    assert(collection.hasPath(["x", "y"]));
    assert(collection.hasPath(["single"]));
    assert(!collection.hasPath(["not", "exist"]));

    // Test hasAllPaths
    assert(collection.hasAllPaths([
          ["a", "b", "c"],
          ["x", "y"]
        ]));
    assert(!collection.hasAllPaths([
          ["a", "b", "c"],
          ["not", "exist"]
        ]));

    // Test hasAnyPath
    assert(collection.hasAnyPath([
          ["not", "exist"],
          ["x", "y"]
        ]));
    assert(!collection.hasAnyPath([
          ["foo"],
          ["bar"]
        ]));
  }

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
  bool removeMany(string[][] paths) {
    return paths.all!(path => remove(path));
  }

  bool remove(string[] path) {
    return remove(path.toKey);
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

  bool hasAlls(string[] keys) {
    return keys.all!(key => has(key));
  }

  bool hasAny(string[] keys) {
    return keys.any!(key => has(key));
  }

  bool has(string key) {
    return key in _items ? true : false;
  }

  // #region correct
  // #endregion correct
  // #endregion keys

  // #region items
  T[] items() {
    return _items.values;
  }

  mixin(HasMethods!("Items", "Item", "T"));

  bool hasItem(T item) {
    foreach (obj; _items.values) {
      // if (obj.isEquals(item)) { return true; }
    }
    return false;
  }

  unittest {
    /*     auto collection = new DCollection!string;
    collection.set("a", "valueA");
    collection.set("b", "valueB");
    collection.set("c", "valueC");
    assert(collection.hasItem("valueA"));
    assert(!collection.hasItem("nonexistent"));
 */
  }
  // #endregion items

  // #region getter
  T getPath(string[] path) {
    return get(path.join(_pathSeparator));
  }

  T getKey(string key) {
    return key in _items ? _items[key] : null;
  }
  // #endregion getter

  // #region setter
  O set(this o)(T[string] newItems) {
    newItems.byKeyValue.each!(kv => set(kv.key, kv.value));
    return cast(O)this;
  }

  O set(this o)(string[] path, T newItem) {
    set(path.join(_pathSeparator), newItem);
    return cast(O)this;
  }

  void opIndexAssign(string key, T newItem) {
    set(key, newItem);
  }

  O set(this O)(string key, T newItem) {
    _items[key] = newItem;
    return cast(O)this;
  }
  // #endregion setter

  // #region remove
  bool removeMany(string[][] paths) {
    return paths.all!(path => remove(path));
  }

  bool remove(string[] path) {
    return remove(correctKey(path));
  }

  bool removeMany(string[] keys) {
    return keys.all!(key => remove(key));
  }

  bool remove(string key) {
    return remove(correctKey(key));
  }

  void clear() {
    _items = null;
  }
  // #endregion remove
}

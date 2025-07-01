/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.patterns.collection;

mixin(Version!"test_uim_oop");

import uim.oop;
@safe:

class DCollection(T : UIMObject) : UIMObject, IKeyAndPath, ICollection!T {
  this() {
    super("Collection");
  }

  this(Json[string] initData) {
    super("Collection", initData);
  }

  this(string newName, Json[string] initData = null) {
    this(initData).name(newName);
  }

  override bool initialize(Json[string] initData = null) {
    if (!super.initialize(initData)) {
      return false;
    }

    return true;
  }

  protected string _pathSeparator = ".";
  protected T[string] _items;

  size_t count() {
    return _items.length;
  }

  // #region paths
  string[][] paths() {
    return _items.keys.map!(key => key.split(_pathSeparator)).array;
  }

  mixin(HasMethods!("Paths", "Path", "string[]"));
  
  bool hasPath(string[] path) {
    return hasKey(path.join(_pathSeparator));
  }

  unittest {
/*     auto collection = new DCollection!string;
    collection.set("a.b.c", "value");
    assert(collection.hasPath(["a", "b", "c"]));
    assert(!collection.hasPath(["a", "b", "x"]));
 */  }
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

  mixin(HasMethods!("Keys", "Key", "string"));

  bool hasKey(string key) {
    return key in _items ? true : false;
  }

  // #region correct
  string correctKey(string[] path) {
    return correctKey(path.join(_pathSeparator));
  }

  string correctKey(string key) {
    return key.strip;
  }
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
 */  }
  // #endregion items

  // #region getter
  T get(string[] path) {
    return get(path.join(_pathSeparator));
  }

  T get(string key) {
    return key in _items ? _items[key] : null;
  }
  // #endregion getter

  // #region setter
  O set(this o)(T[string] newItems) {
    newItems.byKeyValue.each!(kv => set(kv.key, kv.value));
    return cast(O) this;
  }

  O set(this o)(string[] path, T newItem) {
    set(path.join(_pathSeparator), newItem);
    return cast(O) this;
  }

  void opIndexAssign(string key, T newItem) {
    set(key, newItem);
  }

  O set(this O)(string key, T newItem) {
    _items[key] = newItem;
    return cast(O) this;
  }
  // #endregion setter

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
    _items = null;
  }
  // #endregion remove
}

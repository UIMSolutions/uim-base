/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.collections.collection;

import uim.oop;

mixin(Version!"test_uim_oop");
@safe:

class DCollection(T) : DContainer, ICollection!T {
  mixin(CollectionThis!());

  protected T[string] _elements;

  // #region clear
  override bool clear() {
    _elements.clear();
    return true;
  }
  // #endregion clear

  // Returns the entire collection as a map of keys to items.
  T[string] elements() {
    return _elements.dup;
  }

  // #region size
  // Returns the number of items in the collection.
  override size_t size() {
    return _elements.length;
  }
  // #endregion size


  // #region set
  // Sets the entire collection to the specified items.
  bool setKeys(T[string] items) {
    foreach (k, v; _elements) {
      if (!setKey(k, v))
        return false;
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
    _elements[key.correctKey] = item;
    return true;
  }
  // #endregion set

  // #region update
  // Updates the entire collection to the specified items.
  bool updateKeys(T[string] items) {
    foreach (k, v; items) {
      if (!updateKey(k, v))
        return false;
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
    foreach (k, v; items) {
      if (!mergeKey(k, v))
        return false;
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
    _elements.clear();
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

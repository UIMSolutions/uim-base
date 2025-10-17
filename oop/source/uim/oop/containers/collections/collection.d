/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.collections.collection;

import uim.oop;

mixin(Version!"test_uim_oop");
@safe:

class DCollection(V) : DContainer, ICollection!V {
  mixin(CollectionThis!());

  // #region elements
  protected V[string] _elements;
  // Returns the entire collection as a map of keys to items.
  V[string] elements() {
    return _elements.dup;
  }
  // #endregion elements

  // #region clear
  override bool clear() {
    _elements.clear();
    return true;
  }
  // #endregion clear

  // #region has 
  // Returns true if this collection contains the specified element.
  bool hasAll(V[] values) {
    return values.all!(value => has(value));
  }
  // Returns true if this collection contains any of the specified elements.
  bool hasAny(V[] values) {
    return values.any!(value => has(value));
  }
  // Returns true if this collection contains the specified element.
  bool has(V value) {
    return _elements.contains(value);
  }
  // #endregion has

  // #region size
  // Returns the number of items in the collection.
  override size_t size() {
    return _elements.length;
  }
  // #endregion size

  // #region remove
  // Removes all of the elements from this collection (optional operation).
  bool removeAll(V[] values) {
    return values.any!(value => remove(value));
  }

  // Removes any of the elements from this collection (optional operation).
  bool removeAny(V[] values) {
    return values.any!(value => remove(value));
  }

  // Removes the specified element from this collection (optional operation).
  bool remove(V value) {
    return _elements.remove(value);
  }
  // #endregion remove
  // #endregion keys


  bool isEqual(ICollection!V other) {
    if (other is null || size != other.size)
      return false;

    return hasAll(other.toArray());
  }

  // #region toArray
  // Returns an array containing all of the elements in this collection.
  V[] toArray() {
    return _elements.byValue.array;
  }

  V[] toArray(V[] values) {
    return values.filter!(value => has(value)).array;
  } 
  // #endregion toArray
}

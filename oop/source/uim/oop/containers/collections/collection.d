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
  protected V[] _elements;
  // Returns the entire collection as a map of keys to items.
  V[] elements() {
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
  // #region hasAllValue 
  // Returns true if this collection contains the specified element.
  bool hasAllValue(V[] values) {
    return values.all!(value => hasValue(value));
  }
  // #endregion hasAllValue 
  
  // #region hasAnyValue 
  // Returns true if this collection contains any of the specified elements.
  bool hasAnyValue(V[] values) {
    return values.any!(value => hasValue(value));
  }
  // #endregion hasAnyValue 

  // #region hasValue 
  // Returns true if this collection contains the specified element.
  bool hasValue(V value) {
    /* foreach(v; elements) {
      if (v == value) {
        return true;
      }
    } */ 
    return false;
  }
  // #endregion hasValue 
  // #endregion has

  // #region size
  // Returns the number of items in the collection.
  override size_t size() {
    return _elements.length;
  }
  // #endregion size

  // #region add
  // Adds all of the elements in the specified array to this collection (optional operation).
  bool addAllValue(V[] values) {
    return values.all!(value => addValue(value));
  }

  // Adds any of the elements in the specified array to this collection (optional operation).
  bool addAnyValue(V[] values) {
    return values.any!(value => addValue(value));
  }
  
  // Adds the specified element to this collection (optional operation).
  bool addValue(V value) {
    _elements ~= value;
    return true;
  }
  // #endregion add

  // #region remove
  // Removes all of the elements from this collection (optional operation).
  bool removeAllValue(V[] values) {
    return values.any!(value => removeValue(value));
  }

  // Removes any of the elements from this collection (optional operation).
  bool removeAnyValue(V[] values) {
    return values.any!(value => removeValue(value));
  }

  // Removes the specified element from this collection (optional operation).
  bool removeValue(V value) {
    // _elements.remove(value);
    return true;
  }
  // #endregion remove
  // #endregion keys


  bool isEqual(ICollection!V other) {
    if (other is null || size != other.size)
      return false;

    return hasAllValue(other.toArray());
  }

  // #region toArray
  // Returns an array containing all of the elements in this collection.
  V[] toArray() {
    // return _elements.byValue.array;
    return null;
  }

  V[] toArray(V[] values) {
    // return values.filter!(value => hasValue(value)).array;
    return null;
  } 
  // #endregion toArray
}

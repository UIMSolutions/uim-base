/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.collections.collection;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

/// Provides a basic collection with methods to add, remove, and check for elements.
class UIMCollection(V) : UIMContainer, ICollection!V {
  mixin(CollectionThis!());

  // #region elements
  protected V[] _elements;
  /** 
    * Returns an array containing all of the elements in this collection.
    * 
    * Returns: 
    *   An array of elements in the collection
    */
  V[] elements() {
    return _elements.dup;
  }
  // #endregion elements

  // #region has 
  // #region hasAllValue 
  /** 
    * Checks if this collection contains all of the specified elements.
    * 
    * Params: 
    *   values = The values to check
    * Returns: 
    *   'true' if all values are present, 'false' otherwise
    */
  bool hasAllValue(V[] values) {
    return values.all!(value => hasValue(value));
  }
  /// 
  unittest {
    // Test hasAllValue with empty collection
    auto collection1 = new UIMCollection!int;
    assert(collection1.hasAllValue([]));
    assert(!collection1.hasAllValue([1, 2, 3]));

  // Test hasAllValue with single element
    auto collection2 = new UIMCollection!int;
    collection2.addValue(1);
    assert(collection2.hasAllValue([1]));
    assert(!collection2.hasAllValue([2]));
    assert(!collection2.hasAllValue([1, 2]));

    // Test hasAllValue with multiple elements
    auto collection3 = new UIMCollection!int;
    collection3.addValue(1);
    collection3.addValue(2);
    collection3.addValue(3);
    
    assert(collection3.hasAllValue([1]));
    assert(collection3.hasAllValue([1, 2]));
    assert(collection3.hasAllValue([1, 2, 3]));
    assert(collection3.hasAllValue([3, 1, 2])); // Order shouldn't matter
    assert(!collection3.hasAllValue([1, 2, 3, 4]));
    assert(!collection3.hasAllValue([4]));

    // Test hasAllValue with duplicates in input
    auto collection4 = new UIMCollection!int;
    collection4.addValue(1);
    collection4.addValue(2);
    
    assert(collection4.hasAllValue([1, 1, 2]));
    assert(collection4.hasAllValue([2, 2, 2]));
  }
  // #endregion hasAllValue 

  // #region hasAnyValue 
  /** 
    * Checks if this collection contains any of the specified elements.
    * 
    * Params: 
    *   values = The values to check
    * Returns: 
    *   'true' if any value is present, 'false' otherwise
    */
  bool hasAnyValue(V[] values) {
    return values.any!(value => hasValue(value));
  }
  // #endregion hasAnyValue 

  // #region hasValue 
  /** 
    * Checks if this collection contains the specified element.
    * 
    * Params: 
    *   value = The value to check
    * Returns: 
    *   'true' if the value is present, 'false' otherwise
  */
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
  /** 
    * Returns the number of elements in this collection.
    *
    * Returns: 
    *   The size of the collection
    */
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

  // Add an item to the set. Returns true if the item was added, false if it was already present.
  bool addValue(V value) {
    if (hasValue(value)) {
      return false;
    }
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
    if (_elements.length == 0) {
      return false;
    }

    size_t pos;
    bool found = false;
    foreach (index, element; _elements) {
      bool equal = false;
      () @trusted { equal = (element == value); }();
      if (equal) {
        pos = index;
        found = true;
        break;
      }
    }
    if (!found) {
      return false;
    }

    _elements = _elements[0 .. pos] ~ _elements[pos + 1 .. $];
    return true;
  }
  // #endregion remove
  // #endregion keys

  // #region clear
  // Removes all of the elements from this collection (optional operation).
  override void clear() {
    _elements.clear();
  }
  // #endregion clear

  // #region isEqual
  // Compares the specified object with this collection for equality.
  bool isEqual(Object other) {
    auto casted = cast(ICollection!V)other;
    if (casted is null || size != casted.size) {
      return false;
    }
    return casted.toArray().all!(value => hasValue(value));
  }

  size_t indexOfValue(V value) {
    foreach (i, element; _elements) {
      if (element.isEqual(value)) {
        return i; // Return the index if the item is found.
      }
    }
    return -1;
  }
  // #endregion isEqual

  // #region toArray
  // Returns an array containing all of the elements in this collection.
  V[] toArray() {
    return _elements.dup;
  }

  V[] toArray(V[] values) {
    // return values.filter!(value => hasValue(value)).array;
    return null;
  }
  // #endregion toArray
}

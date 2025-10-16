/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.collections.interfaces;

mixin(Version!"test_uim_oop");

import uim.oop;
@safe:

interface ICollection(V) {
  bool clear();

  // #region has 
  // Returns true if this collection contains the specified element.
  bool hasAll(V[] values);
  // Returns true if this collection contains any of the specified elements.
  bool hasAny(V[] values);
  // Returns true if this collection contains the specified element.
  bool has(V value);
  // #endregion has

  // #region add
  // Adds all of the elements in the specified array to this collection (optional operation).
  bool addAll(V[] values);
  // Adds any of the elements in the specified array to this collection (optional operation).
  bool addAny(V[] values);
  // Adds the specified element to this collection (optional operation).
  bool add(V value);
  // #endregion add

  // Returns true if this collection contains no elements.
  bool isEmpty();

  // #region remove
  // Removes all of the elements from this collection (optional operation).
  bool removeAll(V[] values);
  // Removes any of the elements from this collection (optional operation).
  bool removeAny(V[] values);
  // Removes the specified element from this collection (optional operation).
  bool remove(V value);
  // #endregion remove

  // Returns the number of elements in this collection.
  size_t size();

  bool isEqual(ICollection!V other);

  // #region toArray
  // Returns an array containing all of the elements in this collection.
  V[] toArray();
  V[] toArray(V[] values);
  // #endregion toArray
}

 
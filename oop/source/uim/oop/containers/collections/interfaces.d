/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.collections.interfaces;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

interface ICollection(V) : IContainer {
  // #region has 
  // Returns true if this collection contains the specified element.
  bool hasAllValue(V[] values);
  // Returns true if this collection contains any of the specified elements.
  bool hasAnyValue(V[] values);
  // Returns true if this collection contains the specified element.
  bool hasValue(V value);
  // #endregion has

  // #region add
  // Adds all of the elements in the specified array to this collection (optional operation).
  bool addAllValue(V[] values);
  // Adds any of the elements in the specified array to this collection (optional operation).
  bool addAnyValue(V[] values);
  // Adds the specified element to this collection (optional operation).
  bool addValue(V value);
  // #endregion add

  // #region remove
  // Removes all of the elements from this collection (optional operation).
  bool removeAllValue(V[] values);
  // Removes any of the elements from this collection (optional operation).
  bool removeAnyValue(V[] values);
  // Removes the specified element from this collection (optional operation).
  bool removeValue(V value);
  // #endregion remove

  // Removes all of the elements from this collection (optional operation).
  void clear();


  bool isEqual(ICollection!V other);

  // #region toArray
  // Returns an array containing all of the elements in this collection.
  V[] toArray();
  V[] toArray(V[] values);
  // #endregion toArray
}

 
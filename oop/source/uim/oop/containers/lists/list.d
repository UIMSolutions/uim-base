/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.lists.list;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

/// A list container class implementing IList interface.
class UIMList(V) : UIMCollection!V, IList!V {
  mixin(ListThis!(null, true));

  // Initializes this container with optional JSON data.
  override bool initialize(Json[string] initData = null) {
    name("List");
    if (!super.initialize(initData)) {
      return false;
    }
    return true;
  }

  // Add an item to the list. Returns true if the item was added, false if it was already present.
  override bool addValue(V item) {
    _elements ~= item; // Append the item to the internal elements array.
    return true;
  }

  V value(size_t index) {
    return _elements[index]; // Return the item at the specified index.
  }

  // Convert the list to an array.
  override V[] toArray() {
    return _elements.dup; // Return a duplicate of the internal elements array.
  }

  // Get the index of an item in the list. Returns -1 if the item is not found.
  size_t indexOf(V item) {
    foreach(i, element; _elements) {
      if (element.isEqual(item)) {
        return i; // Return the index if the item is found.
      }
    }
    return -1; // Return -1 if the item is not found.
  }

  // Get the size of the list.
  override size_t size() {
    return _elements.length; // Return the number of elements in the list.
  }

  // Check if the list contains a specific item.
  override bool hasValue(V item) {
    return _elements.any!(a => a.isEqual(item)); // Return true if the item is found in the list.
  }

  // Remove an item from the list. Returns true if the item was removed, false if it was not found.
  override bool removeValue(V item) {
    auto index = indexOfValue(item); // Find the index of the item to be removed.
    if (index == -1) { // Item not found in the list.
      return false; 
    }
    _elements = _elements[0 .. index] ~ _elements[index + 1 .. $];
    return true;
  }

  override void clear() {
    _elements.clear(); // Clear all elements from the list.
  }
}

/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.lists.list;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

class UIMList(V) : DCollection!V, IList!V {
  mixin(ListThis!(null, true));
  // Add an item to the list. Returns true if the item was added, false if it was already present.
  override bool add(V item) {
    _elements ~= item; // Append the item to the internal elements array.
    return true;
  }

  V get(size_t index) {
    return _elements[index]; // Return the item at the specified index.
  }

  // Convert the list to an array.
  override V[] toArray() {
    return _elements.dup; // Return a duplicate of the internal elements array.
  }

  // Check if the list is empty.
  override bool isEmpty() {
    return _elements.length == 0; // Return true if the list has no elements.
  }

  // Get the index of an item in the list. Returns -1 if the item is not found.
  size_t indexOf(V item) {
    return _elements.indexOf(item); // Return the index of the item in the list.
  }

  // Get the size of the list.
  override size_t size() {
    return _elements.length; // Return the number of elements in the list.
  }

  // Check if the list contains a specific item.
  override bool hasValue(V item) {
    return _elements.canFind(item); // Check if the item exists in the list.
  }

  // Remove an item from the list. Returns true if the item was removed, false if it was not found.
  override bool removeValue(V item) {
    auto index = _elements.indexOf(item); // Find the index of the item to be removed.
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

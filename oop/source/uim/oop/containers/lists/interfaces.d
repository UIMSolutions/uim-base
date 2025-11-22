/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.lists.interfaces;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

interface IList(T) : IContainer {
  // Check if the set is empty.
  bool isEmpty();

  // Add an item to the set. Returns true if the item was added, false if it was already present.
  bool add(in T item);

  // Check if the set contains the specified item.
  bool contains(in T item);

  // Get an item by its index.
  T get(size_t index);
  
  // Get the number of items in the set.
  size_t size();

  // Remove an item from the set. Returns true if the item was removed, false if it was not found.
  bool remove(in T item);

  // Clear all items from the set.
  void clear();

  // Convert the set to an array.
  T[] toArray();
}


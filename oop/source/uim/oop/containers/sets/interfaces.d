module uim.oop.containers.sets.interfaces;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

interface ISet(T) : IContainer {
  // Check if the set is empty.
  bool isEmpty();

  // Add an item to the set. Returns true if the item was added, false if it was already present.
  bool add(in T item);

  // Check if the set contains the specified item.
  bool contains(in T item);

  // Get the number of items in the set.
  size_t size();

  // Remove an item from the set. Returns true if the item was removed, false if it was not found.
  bool remove(in T item);

  // Clear all items from the set.
  void clear();

  // Convert the set to an array.
  T[] toArray();
}

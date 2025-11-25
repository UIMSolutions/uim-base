module uim.oop.containers.sets.interfaces;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

// A set is a collection that contains no duplicate elements.
interface ISet(V) : ICollection!V {
  // Add an item to the set. Returns true if the item was added, false if it was already present.
  bool addValue(V item);

  // Check if the set contains the specified item.
  bool hasValue(V item);

  // Remove an item from the set. Returns true if the item was removed, false if it was not found.
  bool removeValue(V item);

  // Convert the set to an array.
  V[] toArray();
}

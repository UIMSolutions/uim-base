module uim.oop.containers.interfaces;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

interface IContainer {
  // Returns true if this collection contains no elements.
  bool isEmpty();

  // Returns the number of elements in this collection.
  size_t size();

  // Removes all of the elements from this container
  void clear();
}
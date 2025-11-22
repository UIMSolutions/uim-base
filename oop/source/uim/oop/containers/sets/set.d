module uim.oop.containers.sets.set;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

class DSet(V) : DCollection!V, ISet!V {
  // Check if the set contains the specified item.
  bool hasValue(in V item) {
    return _elements.canFind(item);
  }

  // Remove an item from the set. Returns true if the item was removed, false if it was not found.
  bool remove(in V item) {
    auto index = _elements.indexOf(item);
    if (index == -1) {
      return false;
    }
    _elements = _elements[0 .. index] ~ _elements[index + 1 .. $];
    return true;
  }
}
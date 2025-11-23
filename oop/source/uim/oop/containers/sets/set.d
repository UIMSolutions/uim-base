module uim.oop.containers.sets.set;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

class DSet(V) : DCollection!V, ISet!V {
  // Check if the set contains the specified item.
  override bool hasValue(in V item) {
    return _elements.canFind(item);
  }

  // Remove an item from the set. Returns true if the item was removed, false if it was not found.
  override bool removeValue(in V item) {
    auto index = _elements.indexOf(item);
    if (index == -1) {
      return false;
    }
    _elements = _elements[0 .. index] ~ _elements[index + 1 .. $];
    return true;
  }

  override V[] toArray() {
    return _elements.dup;
  }

  override size_t size() {
    return _elements.length;
  } 

  override bool add(in V item) {
    if (hasValue(item)) {
      return false;
    }
    _elements ~= item;
    return true;
  }
}
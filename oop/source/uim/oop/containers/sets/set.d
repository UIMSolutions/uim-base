module uim.oop.containers.sets.set;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

class DSet(V) : DCollection!V, ISet!V {
  // Check if the set is empty.
  bool isEmpty() {
    return size == 0;
  }

  // Add an item to the set. Returns true if the item was added, false if it was already present.
  bool add(in V item) {
    if (contains(item)) {
      return false;
    }
    _items ~= item;
    return true;
  }

  // Check if the set contains the specified item.
  bool contains(in V item) {
    return _items.canFind(item);
  }

  // Get the number of items in the set.
  size_t size() {
    return _items.length;
  }

  // Remove an item from the set. Returns true if the item was removed, false if it was not found.
  bool remove(in V item) {
    auto index = _items.indexOf(item);
    if (index == -1) {
      return false;
    }
    _items = _items[0 .. index] ~ _items[index + 1 .. $];
    return true;
  }

  // Clear all items from the set.
  void clear() {
    _items = null;
  }

  // Convert the set to an array.
  V[] toArray() {
    return _items.dup;
  }
}
module uim.oop.containers.sets.set;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

/// A set container class implementing ISet interface.
class UIMSet(V) : UIMCollection!V, ISet!V {
  mixin(SetThis!());

  // #region size
  // Returns the number of items in the collection.
  override size_t size() {
    return super.size;
  }
  // #endregion size

  // Check if the set contains the specified item.
  override bool hasValue(V item) {
    return super.hasValue(item);
    //
  }

  // Remove an item from the set. Returns true if the item was removed, false if it was not found.
  override bool removeValue(V item) {
    auto index = indexOfValue(item);
    if (index == -1) {
      return false;
    }
    _elements = _elements[0 .. index] ~ _elements[index + 1 .. $];
    return true;
  }

  override V[] toArray() {
    return _elements.dup;
  }

  override bool addValue(V value) {
    if (hasValue(value)) {
      return false;
    }
    _elements ~= value;
    return true;
  }

    // #region clear
  // Removes all of the elements from this collection (optional operation).
  override void clear() {
    super.clear();
  }
  // #endregion clear
}
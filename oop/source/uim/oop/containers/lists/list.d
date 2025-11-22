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
  // Add an item to the list. Returns true if the item was added, false if it was already present.
  override bool add(in V item) {
    _elements ~= item;
    return true;
  }

  override V[] toArray() {
    return _elements.dup;
  }

override bool isEmpty() {
    return _elements.length == 0;
  }
  override size_t indexOf(in V item) {
    return _elements.indexOf(item);
  }

  override size_t size() {
    return _elements.length;
  }

  override bool hasValue(in V item) {
    return _elements.canFind(item);
  }

  override bool removeValue(in V item) {
    auto index = _elements.indexOf(item);
    if (index == -1) {
      return false;
    }
    _elements = _elements[0 .. index] ~ _elements[index + 1 .. $];
    return true;
  }
}

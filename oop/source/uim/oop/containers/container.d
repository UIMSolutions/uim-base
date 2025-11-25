/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.container;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

abstract class UIMContainer : UIMObject, IContainer {
  this() {
    initialize;
  }

  // Initializes this container with optional JSON data.
  this(string name, Json[string] initData = null) {
    initialize(initData);
    this.name(name);
  }

  // Initializes this container with optional JSON data.
  this(Json[string] initData = null) {
    initialize(initData);
  }

  // Initializes this container with optional JSON data.
  override bool initialize(Json[string] initData = null) {
    name("Container");
    if (!super.initialize(initData)) {
      return false;
    }
    return true;
  }

  // #region isEmpty
  // Check if the set is empty.
  override bool isEmpty() {
    return size == 0;
  }
  // #endregion isEmpty
  // Returns the number of elements in this container.*/
  size_t size() {
    return 0;
  }

  // #region clear
  // Removes all of the elements from this container */
  void clear() {
    // Default implementation does nothing.
  }
  // #region clear
}

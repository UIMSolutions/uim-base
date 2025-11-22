/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.validators.validator;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

// Base class for validators
class DUIMValidator : UIMObject, IValidator {
  /*    mixin TLocatorAware;
    mixin TLog; */

  override bool initialize(Json[string] initData = null) {
    if (!super.initialize(initData)) {
      return false;
    }

    return true;
  }

  // #region IObject
  // Get the name of the object.
  override string name() {
    return super.name;
  }

  // Get or set the name of the object.
  override void name(string newName) {
    super.name(newName);
  }

  // Compares two IObject instances for equality based on their names.
  override bool isEqual(IObject other) {
    if (!super.isEqual(other)) {
      return false;
    }

    if (this is other) {
      return true;
    }
    if (this.classinfo !is other.classinfo) {
      return false;
    }
    if (other is null) {
      return false;
    }
    if (this.name is null || other.name is null) {
      return false;
    }

    return this.name == other.name;
    // TODO: Consider adding more properties for comparison if needed.
  }

  // Returns a string representation comparing two IObject instances.
  override string toString() {
    return "DValidator: " ~ this.name;
  }

  // Creates a clone of the current object.
  override IObject clone() {
    auto registry = new DRegistry!V;
    registry.name(this.name);
    _registeredObjects.each!(
      (key, obj) => registry.setKey(key, obj)
    );
    return registry;
  }
  // #endregion IObject
}

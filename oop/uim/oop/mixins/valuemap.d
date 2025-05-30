/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.mixins.valuemap;

mixin(Version!"test_uim_oop");

import uim.oop;
@safe:

// TODO: addValue(string key, DValue value) to addValues(string[] keys, DValue[] values) to addValues(DValue[string] values) to addValues(DAttribute[string] attributes) to addValues(DAttribute[] attributes)
/* TODO: 
  - addValue(string key, DValue value) to addValues(string[] keys, DValue[] values) to addValues(DValue[string] values) to addValues(DAttribute[string] attributes) to addValues(DAttribute[] attributes)
  - addValue(string key, DAttribute attribute) to addValues(string[] keys, DAttribute[] attributes) to addValues(DAttribute[string] attributes) to addValues(DAttribute[] attributes)
* / 
template ValueMapWrapper(R, V) {
  bool hasValue(string key) {
    if (this.values) { // has values
      return values.hasKey(key);
    }
    return false;
  }

  DValue[] values() {
    if (this.values) {
      return _values.values;
    }
    return null;
  }

  O addValues(this O)(DAttribute[] attributes) {
    attributes.each!(attribute => this.addValue(attribute));
    return cast(O)this;
  }

  O addValue(this O)(DAttribute attribute) {
    if (attribute) this.addValue(attribute.name, attribute.createValue);
    return cast(O)this;
  }

  O addValues(this O)(DAttribute[string] attributes) {
    attributes.byKey.each!(key => this.addValue(key, attributes[key]));
    return cast(O)this;
  }

  O addValue(this O)(string key, DAttribute attribute) {
    if (attribute) this.addValue(key, attribute.createValue);
    return cast(O)this;
  }

  O addValues(this O)(DValue[string] newValues) {
    newValues.byKey.each!(key => this.addValue(key, newValues[key]));
    return cast(O)this;
  }

  O addValue(this O)(string key, DValue newValue) {
    if (this.values) { // has values
      this.values[key] = newValue;
    }
    return cast(O)this;
  }

  DValue getValue(string key) {
    if (this.values) {
      return _values[key];
    }
    return null;
  }

/* DValue[string] getValues(string[] valueKeys) {
    DValue[string] results;
    valueKeys.each!(ḱey => results[key] = this.values[key]);
    return results;
  }
}*/
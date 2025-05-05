/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.core.classes.general;

mixin(Version!("test_uim_core"));

import uim.core;
@safe:

T ifNull(T:Object)(T value, T defaultValue = null) {
  return value !is null ? value : defaultValue;
}

unittest {
  @safe class Test {
    this() {}
    this(int aValue) {
      _value = aValue;
    }
    int _value;
    int value() { return _value; }
  }

  Test withObject = new Test(1);
  Test nullObject;

  assert(withObject.ifNull(new Test(2)).value == 1);
  assert(nullObject.ifNull(new Test(3)).value == 3);
}

// ifEqual
// IfUnequal
// ifLess
// ifGreater

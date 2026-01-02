/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.core.datatypes.json;

import uim.core;

mixin(Version!("test_uim_core"));
@safe:

// #region shift
T shift(T:Json)(auto ref T[] values) {
  switch (values.length) {
  case 0:
    return Json(null);
  case 1:
    T value = values[0];
    values = Json.emptyArray;
    return value;
  default:
    T value = values[0];
    values = values[1 .. $].dup;
    return value;
  }
}

unittest {
  /* string[] testValues;
  assert(testValues.shift is null);

  testValues = ["a"];
  assert(testValues.length == 1);
  assert(testValues.shift == "a");
  assert(testValues.length == 0);

  testValues = ["a", "b", "c"];
  assert(testValues.length == 3);
  assert(testValues.shift == "a");
  assert(testValues.length == 2); */
}
// #endregion shift
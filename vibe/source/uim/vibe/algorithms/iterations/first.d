/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.algorithms.iterations.first;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:


// #region with array of values
T first(T)(T[] values) if (!is(T == string)) {
  return (values.length > 0)
    ? values[0] : Null!T;
}

T first(T:string)(T[] values) {
  return (values.length > 0)
    ? values[0] : null;
}

T first(T:Json)(T[] values) {
  return (values.length > 0)
    ? values[0] : Json(null);
}

unittest {
  // Test first(T)(T[] values) with non-empty int array
  int[] arr = [10, 20, 30];
  assert(first(arr) == 10);

  // Test first(T)(T[] values) with non-empty string array
  string[] strArr = ["a", "b", "c"];
  assert(first(strArr) == "a");

  // Test first(T)(T[] values) with non-empty Json array
  Json[] jsonArr = [Json(1), Json(2)];
  assert(first(jsonArr) == Json(1));

  // Test first(T)(T[] values) with empty Json array
  Json[] emptyJsonArr;
  assert(first(emptyJsonArr) is Json(null));
}
// #endregion with array of values

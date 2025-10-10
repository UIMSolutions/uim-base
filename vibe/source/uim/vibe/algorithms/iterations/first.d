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
T first(T:Json)(T[] values) {
  return (values.length > 0)
    ? values[0] : Json(null);
}

unittest {

  // Test first(T)(T[] values) with non-empty Json array
  Json[] jsonArr = [Json(1), Json(2)];
  assert(jsonArr.first == Json(1));

  // Test first(T)(T[] values) with empty Json array
  Json[] emptyJsonArr;
  assert(emptyJsonArr.first == Json(null));
}
// #endregion with array of values

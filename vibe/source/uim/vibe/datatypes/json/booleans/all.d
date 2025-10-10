/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.json.booleans.all;

import uim.vibe;

mixin(Version!("test_uim_vibe"));
@safe:

// #region Json[]
/**
  * Checks if all specified elements in the array are of boolean type.
  *
  * Params:
  *   values = The array to check.
  *   indices = Optional indices to check within the array. If not provided, all elements are checked.
  *
  * Returns:
  *   `true` if all specified elements are booleans, `false` otherwise.
  *
  * Examples:
  * ```d
  * Json[] arr1 = [Json(true), Json(false), Json(1)];
  * assert(!arr1.isAllBoolean); // false
  *
  * Json[] arr2 = [Json(true), Json(false)];
  * assert(arr2.isAllBoolean); // true
  *
  * Json[] arr3 = [Json(true), Json(false), Json(1)];
  * assert(arr3.isAllBoolean([0, 1])); // true
  * assert(!arr3.isAllBoolean([0, 2])); // false
  * ```
  */
bool isAllBoolean(Json[] values) {
  return values.all!(json => json.isBoolean);
}
/// 
unittest {
  // Test with all booleans
  Json[] arr1 = [Json(true), Json(false)];
  assert(isAllBoolean(arr1), "Should be true: all elements are booleans");

  // Test with mixed types
  Json[] arr2 = [Json(true), Json(1), Json(false)];
  assert(!isAllBoolean(arr2), "Should be false: not all elements are booleans");

  // Test with empty array
  Json[] arr3 = [];
  assert(isAllBoolean(arr3), "Should be true: empty array (vacuously true)");

  // Test with single boolean
  Json[] arr4 = [Json(true)];
  assert(isAllBoolean(arr4), "Should be true: single boolean");

  // Test with single non-boolean
  Json[] arr5 = [Json("string")];
  assert(!isAllBoolean(arr5), "Should be false: single non-boolean");
}

/** 
  * Checks if all specified elements in the array are of boolean type.
  *
  * Params:
  *   values = The array to check.
  *   indices = Optional indices to check within the array. If not provided, all elements are checked.
  *
  * Returns:
  *   `true` if all specified elements are booleans, `false` otherwise.
  *
  * Examples:
  * ```d
  * Json[] arr1 = [Json(true), Json(false), Json(1)];
  * assert(!arr1.isAllBoolean); // false
  *
  * Json[] arr2 = [Json(true), Json(false)];
  * assert(arr2.isAllBoolean); // true
  *
  * Json[] arr3 = [Json(true), Json(false), Json(1)];
  * assert(arr3.isAllBoolean([0, 1])); // true
  * assert(!arr3.isAllBoolean([0, 2])); // false
  * ```
  */
bool isAllBoolean(Json[] values, size_t[] indices) {
  return indices.all!(i => i < values.length && values[i].isBoolean);
}
/// 
unittest {
  // Test with all booleans at specified indices
  Json[] arr = [Json(true), Json(false), Json(1)];
  size_t[] indices1 = [0, 1];
  assert(isAllBoolean(arr, indices1), "Should be true: indices 0 and 1 are booleans");

  // Test with mixed types at specified indices
  size_t[] indices2 = [0, 2];
  assert(!isAllBoolean(arr, indices2), "Should be false: index 2 is not a boolean");

  // Test with out-of-bounds index
  size_t[] indices3 = [0, 3];
  assert(!isAllBoolean(arr, indices3), "Should be false: index 3 is out of bounds");

  // Test with empty indices array
  size_t[] indices4 = [];
  assert(isAllBoolean(arr, indices4), "Should be true: empty indices (vacuously true)");

  // Test with single boolean index
  size_t[] indices5 = [1];
  assert(isAllBoolean(arr, indices5), "Should be true: index 1 is a boolean");

  // Test with single non-boolean index
  size_t[] indices6 = [2];
  assert(!isAllBoolean(arr, indices6), "Should be false: index 2 is not a boolean");
}
// #endregion Json[]

// #region Json[string]
bool isAllBoolean(Json[string] map) {
  return map.byValue.array.isAllBoolean;
}

bool isAllBoolean(Json[string] map, string[] keys) {
  return keys
    .filter!(key => map.hasKey(key))
    .map!(key => map[key])
    .array
    .isAllBoolean;
}
// #endregion Json[string]

// #region Json
bool isAllBoolean(Json json) {
  if (json.isArray) {
    return json.toArray.isAllBoolean;
  }

  if (json.isObject) {
    return json.toMap.isAllBoolean;
  }

  return json.isBoolean;
}
// #endregion Json

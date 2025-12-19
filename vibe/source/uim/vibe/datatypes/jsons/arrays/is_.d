/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.is_;

import uim.vibe;
import uim.vibe.datatypes.jsons.json.types.arrays;

mixin(Version!("test_uim_vibe"));

@safe:

// #region all
// #region noIndex
bool isAllArray(Json[] values) {
  return values.all!(value => uim.vibe.datatypes.jsons.json.types.arrays.isArray(value));
}
// #endregion noIndex

// #region index  
bool isAllArray(Json[] values, size_t[] indices) {
  return indices.all!(index => values.isArray(index));
}
// #endregion index
// #endregion all

// #region any
// #region noIndex
bool isAnyArray(Json[] values) {
  return values.any!(value => uim.vibe.datatypes.jsons.json.types.arrays.isArray(value));
}
// #endregion noIndex

// #region index
bool isAnyArray(Json[] values, size_t[] indices) {
  return indices.any!(index => values.isArray(index));
}
// #endregion index
// #endregion any

// #region is
bool isArray(Json[] values, size_t index) {
  if (index >= values.length) {
    return false;
  } 

  return uim.vibe.datatypes.jsons.json.types.arrays.isArray(values[index]);
}
// #endregion is


bool isAllArray(Json json) {
  if (uim.vibe.datatypes.jsons.json.types.arrays.is_.isArray(json)) {
    return json.toArray.isAllArray;
  }
  if (json.isObject) {
    return json.toMap.isAllArray;
  }
  return false;
}

bool isAllArray(Json[] values) {
  return values.all!(value => uim.vibe.datatypes.jsons.json.types.arrays.is_.isArray(value));
}

bool isAllArray(Json[string] map) {
  return map.byValue.array.isAllArray;
}

bool isAnyArray(Json json) {
  if (uim.vibe.datatypes.jsons.json.types.arrays.is_.isArray(json)) {
    return json.toArray.isAnyArray;
  }
  if (json.isObject) {
    return uim.vibe.datatypes.jsons.objects.types.arrays.is_.isAnyArray(json.toMap);
  }
  return false;
}

bool isArray(Json[] values, size_t index) {
  if (index >= values.length) {
    return false;
  } 

  return uim.vibe.datatypes.jsons.json.types.arrays.is_.isArray(values[index]);
}
/** 
  * Checks if any element in the array is of boolean type.
  *
  * Params:
  *   values = The array to check.
  *
  * Returns:
  *   `true` if any element is a boolean, `false` otherwise.
  *
  * Examples:
  * ```d
  * Json[] array1 = [Json(1), Json(2), Json(3)];
  * assert(!array1.isAnyArray); // false
  *
  * Json[] array2 = [Json(1), Json(true), Json(3)];
  * assert(array2.isAnyArray); // true
  *
  * Json[] arr3 = [Json("a"), Json("b"), Json(false)];
  * assert(arr3.isAnyArray); // true
  * ```
  */
bool isAnyArray(Json[] values) {
  return values.any!(json => uim.vibe.datatypes.jsons.json.types.arrays.isArray(json));
}

bool hasValue(T : Json)(Json json, T value) {
  return uim.vibe.datatypes.jsons.json.types.array_.isArray(json) || json.isObject
    ? json.byValue.any!(v => v == value) : json == value;
}
// #endregion has



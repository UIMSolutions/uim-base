/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.first;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

/// Get the first element from a Json array or return null if empty.
T first(T : Json)(T[] values) {
  return values.length > 0
    ? values[0] : Json(null);
}

// #region first by type
Json firstObject(Json[] items) {
  return items.filterObjects.first;
}

Json firstArray(Json[] items) {
  return items.filterArrays.first;
}

Json firstValue(Json[] items) {
  return items.filterValues.first;
}
// #endregion first by type

// #region first by key
Json firstHasAllKey(Json[] items, string[] keys) {
  return items.filterHasAllKey(keys).first;
}

Json firstHasAnyKey(Json[] items, string[] keys) {
  return items.filterHasAnyKey(keys).first;
}

Json firstHasKey(Json[] items, string key) {
  return items.filterHasKey(key).first;
}
// #endregion first by key
// #endregion Json[]

// #region Json
T first(T : Json)(T value) {
  return value.isArray
    ? first(value.toArray) : value;
}

// #region first by type
Json firstObject(Json json) {
  return json.isArray
    ? json.toArray.filterObjects.first : Json(null);
}

Json firstArray(Json json) {
  return json.isArray
    ? json.toArray.filterArrays.first : Json(null);
}

Json firstValue(Json json) {
  return json.isArray
    ? json.toArray.filterValues.first : Json(null);
}
// #endregion first by type

// #region first by key
Json firstHasAllKey(Json json, string[] keys) {
  return json.isArray
    ? json.toArray.filterHasAllKey(keys).first : Json(null);
}

Json firstHasAnyKey(Json json, string[] keys) {
  return json.isArray
    ? json.toArray.filterHasAnyKey(keys).first : Json(null);
}

Json firstHasKey(Json json, string key) {
  return json.isArray
    ? json.toArray.filterHasKey(key).first : Json(null);
}
// #endregion first by key


/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.containers.jsons.first;

import uim.vibe;

mixin(Version!("test_uim_vibe"));
@safe:

Json first(Json json) {
  if (json.isNull || !json.isArray || json.toArray.length == 0) {
    return Json(null);
  }
  return json.isArray
    ? uim.phobos.containers.arrays.first.first(json.toArray) : Json(null);
}
/// 
unittest {
  // Test with a non-array Json
  Json j1 = Json(42);
  assert(first(j1) == Json(null));

  // Test with an empty array
  Json j2 = Json.emptyArray;
  assert(first(j2) == Json(null));

  // Test with a single-element array
  Json j3 = Json([Json("a")]);
  assert(first(j3) == Json("a"));

  // Test with a multi-element array
  Json j4 = Json([Json("x"), Json("y"), Json("z")]);
  assert(first(j4) == Json("x"));

  // Test with nested arrays
  Json j5 = Json([Json([Json(1), Json(2)]), Json(3)]);
  assert(first(j5) == Json([Json(1), Json(2)]));
}

Json firstObject(Json json) {
  return json.isArray
    ? uim.phobos.containers.arrays.first.first(json.filterObjects) : Json(null);
}

Json firstArray(Json json) {
  return json.isArray
    ? uim.phobos.containers.arrays.first.first(json.filterArrays) : Json(null);
}

Json firstValue(Json json) {
  return json.isArray
    ? uim.phobos.containers.arrays.first.first(json.filterValues) : Json(null);
}

Json firstHasAllKey(Json json, string[] keys) {
  return json.isArray ? json.toArray
    .filter!(json => json.isObject)
    .filter!(json => json.hasAllKey(keys))
    .array.first : Json(null);
}

Json firstHasAnyKey(Json json, string[] keys) {
  return json.isArray ? json.toArray
    .filter!(json => json.isObject)
    .filter!(json => json.hasAnyKey(keys))
    .array
    .first : Json(null);
}

Json firstHasKey(Json json, string key) {
  return json.isArray ? json.toArray
    .filter!(json => json.isObject)
    .filter!(json => json.hasKey(key))
    .array
    .first : Json(null);
}

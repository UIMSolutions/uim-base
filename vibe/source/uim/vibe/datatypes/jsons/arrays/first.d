/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.json.arrays.first;

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

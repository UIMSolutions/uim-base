/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.datatypes.json.arrays.first;

import uim.vibe;
mixin(Version!("test_uim_vibe"));

@safe:

// #region Json[]
T first(T : Json[])(T value) {
  return value.length > 0 
  ? value[0]
  : Json(null);
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
Json firstHasAllKeys(Json[] items, string[] keys) {
  return items.filterHasAllKeys(keys).first;
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
    ? json.toArray.filterObjects.first : Null!Json;
}

Json firstArray(Json json) {
  return json.isArray
    ? json.toArray.filterArrays.first : Null!Json;
}

Json firstValue(Json json) {
  return json.isArray
    ? json.toArray.filterValues.first : Null!Json;
}
// #endregion first by type

// #region first by key
Json firstHasAllKeys(Json json, string[] keys) {
  return json.isArray
    ? json.toArray.filterHasAllKeys(keys).first : Null!Json;
}

Json firstHasAnyKey(Json json, string[] keys) {
  return json.isArray
    ? json.toArray.filterHasAnyKey(keys).first : Null!Json;
}

Json firstHasKey(Json json, string key) {
  return json.isArray
    ? json.toArray.filterHasKey(key).first : Null!Json;
}
// #endregion first by key
// #endregion Json

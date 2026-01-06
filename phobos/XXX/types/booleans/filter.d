/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.types.booleans.filter;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

// #region Json[]
// #region filter with indices and filterFunc
Json[] filterBooleans(Json[] jsons, size_t[] indices, bool delegate(Json) @safe filterFunc) {
  if (indices.length == 0) {
    return null;
  }

  return jsons.filterValues(indices);
}
// #endregion filter with indices and filterFunc

// #region filter with indices
Json[] filterBooleans(Json[] jsons, size_t[] indices) {
  return jsons.filterValues(indices).filterBooleans;
}

// #endregion filter with indices

// #region filter with filterFunc
Json[] filterBooleans(Json[] jsons, bool delegate(Json) @safe filterFunc) {
  return jsons.filterValues((Json json) => filterFunc(json)).filterBooleans;
}

// #endregion filter with filterFunc

// #region filter all booleans
Json[] filterBooleans(Json[] jsons) {
  return jsons.filterValues((Json json) => json.isBoolean);
}

// #endregion filter all booleans
// #endregion Json[]

// #region Json[string]
Json[string] filterBooleans(Json[string] map, string[] keys, bool delegate(string) @safe filterFunc) {
  return map.filterMap(keys, (string key) => filterFunc(key));
}

Json[string] filterBooleans(Json[string] map, Json[] values, bool delegate(Json) @safe filterFunc) {
  return map.filterBooleans(values).filterBooleans(filterFunc);
}
Json[string] filterBooleans(Json[string] map, string[] keys) {
  return map.filterKeys(keys).filterBooleans;
}

Json[string] filterBooleans(Json[string] map, Json[] values) {
  return map.filterValues(values).filterBooleans;
}

Json[string] filterBooleans(Json[string] map, bool delegate(string) @safe filterFunc) {
  return map.filterMap((string key, Json json) => filterFunc(key)).filterBooleans;
}

Json[string] filterBooleans(Json[string] map, bool delegate(Json) @safe filterFunc) {
  return map.filterMap((string key, Json json) => filterFunc(json)).filterBooleans;
}

Json[string] filterBooleans(Json[string] map, bool delegate(string, Json) @safe filterFunc) {
  return map.filterMap((string key, Json json) => filterFunc(key, json)).filterBooleans;
}

Json[string] filterBooleans(Json[string] map) {
  return map.filterMap((string key, Json json) => json.isBoolean);
}

// #region Json[string]

// #region Json
Json filterBooleans(Json json, size_t[] indices, bool delegate(Json) @safe filterFunc) {
  return json.filterValues(indices, (Json json) => json.isBoolean && filterFunc(json));
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing filterBooleans for Json with indices and filterFunc");

  Json json = [true.toJson, "not a boolean".toJson, false.toJson, 42.toJson].toJson;

  auto filtered1 = json.filterBooleans([0, 2]);
  assert(filtered1.isArray);
  assert(filtered1.toArray.length == 2);

  auto filtered2 = json.filterBooleans((Json j) @safe => j.isBoolean && j.toBoolean);
  assert(filtered2.isArray);
  assert(filtered2.toArray.length == 1);

  auto filtered = json.filterBooleans([0, 2], (Json j) @safe => j.isBoolean && j.toBoolean);
  assert(filtered.isArray);
  assert(filtered.toArray.length == 1);
  assert(filtered.toArray[0] == true.toJson);
}

Json filterBooleans(Json json, size_t[] indices) {
  return json.filterValues(indices, (Json json) => json.isBoolean);
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing filterBooleans for Json with indices");

  Json json = [true.toJson, "not a boolean".toJson, false.toJson, 42.toJson].toJson;
  auto filtered = json.filterBooleans([0, 1, 2]);
  assert(filtered.isArray);
  assert(filtered.toArray.length == 2);
  assert(filtered.toArray[0] == true.toJson);
  assert(filtered.toArray[1] == false.toJson);
}

Json filterBooleans(Json json, bool delegate(Json) @safe filterFunc) {
  return json.filterValues((Json json) => json.isBoolean && filterFunc(json));
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing filterBooleans for Json with filterFunc");

  Json json = [true.toJson, "not a boolean".toJson, false.toJson, 42.toJson].toJson;
  auto filtered = json.filterBooleans((Json j) @safe => !j.toBoolean);
  assert(filtered.isArray);
  assert(filtered.toArray.length == 1);
  assert(filtered.toArray[0] == false.toJson);
}

Json filterBooleans(Json json) {
  return json.filterValues((Json json) => json.isBoolean);
}
// #region Json

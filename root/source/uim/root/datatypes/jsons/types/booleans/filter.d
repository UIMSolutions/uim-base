module uim.root.datatypes.jsons.types.booleans.filter;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

// #region Json[]
// #region filter with indices and filterFunc
Json[] filterBooleans(Json[] jsons, size_t[] indices, bool delegate(Json) @safe filterFunc) {
  return jsons.filterValues(indices).filterBooleans;
}
/// 
unittest {
  version (test_uim_root) writeln("Testing filterBooleans for Json[] with indices and filterFunc");

  Json[] jsons = [true.toJson, "not a boolean".toJson, false.toJson, 42.toJson];

  auto filtered1 = jsons.filterBooleans([0, 2]);
  assert(filtered1.length == 2);

  auto filtered2 = jsons.filterBooleans((Json json) @safe => json.isBoolean && json.getBoolean);
  assert(filtered2.length == 1);

  auto filtered = jsons.filterBooleans([0, 2], (Json json) @safe => json.isBoolean && json.getBoolean);
  assert(filtered.length == 1);
  assert(filtered[0] == true.toJson);
}
// #endregion filter with indices and filterFunc

// #region filter with indices
Json[] filterBooleans(Json[] jsons, size_t[] indices) {
  return jsons.filterValues(indices).filterBooleans;
}
/// 
unittest {
  version (test_uim_root) writeln("Testing filterBooleans for Json[] with indices");

  Json[] jsons = [true.toJson, "not a boolean".toJson, false.toJson, 42.toJson];
  auto filtered = jsons.filterBooleans([0, 1, 2]);
  assert(filtered.length == 2);
  assert(filtered[0] == true.toJson);
  assert(filtered[1] == false.toJson);
}
// #endregion filter with indices

// #region filter with filterFunc
Json[] filterBooleans(Json[] jsons, bool delegate(Json) @safe filterFunc) {
  return jsons.filterValues((Json json) => filterFunc(json)).filterBooleans;
}
/// 
unittest {
  version (test_uim_root) writeln("Testing filterBooleans for Json[] with filterFunc");

  Json[] jsons = [true.toJson, "not a boolean".toJson, false.toJson, 42.toJson];
  auto filtered = jsons.filterBooleans((Json json) @safe => !json.getBoolean);
  assert(filtered.length == 1);
  assert(filtered[0] == false.toJson);
}
// #endregion filter with filterFunc

// #region filter all booleans
Json[] filterBooleans(Json[] jsons) {
  return jsons.filterValues((Json json) => json.isBoolean);
}
/// 
unittest {
  version (test_uim_root) writeln("Testing filterBooleans for Json[]");

  Json[] jsons = [true.toJson, "not a boolean".toJson, false.toJson, 42.toJson];
  auto filtered = jsons.filterBooleans;
  assert(filtered.length == 2);
  assert(filtered[0] == true.toJson);
  assert(filtered[1] == false.toJson);
}
// #endregion filter all booleans
// #endregion Json[]

// #region Json[string]
Json[string] filterBooleans(Json[string] map, string[] keys, bool delegate(string) @safe filterFunc) {
  return map.filterBooleans(keys).filterBooleans(filterFunc);
}
/// 
unittest {
  version (test_uim_root) writeln("Testing filterBooleans for Json[string] with keys and filterFunc");

  Json[string] map = [
    "a": true.toJson,
    "b": "not a boolean".toJson,
    "c": false.toJson,
    "d": 42.toJson
  ];

  auto filtered1 = map.filterBooleans(["a", "c"]);
  assert(filtered1.length == 2);

  auto filtered2 = map.filterBooleans((string key) @safe => key == "a");
  assert(filtered2.length == 1);

  auto filtered = map.filterBooleans(["a", "c"], (string key) @safe => key == "a");
  assert(filtered.length == 1);
  assert(filtered["a"] == true.toJson);
}

Json[string] filterBooleans(Json[string] map, Json[] values, bool delegate(Json) @safe filterFunc) {
  return map.filterBooleans(values).filterBooleans(filterFunc);
}
/// 
unittest {
  version (test_uim_root) writeln("Testing filterBooleans for Json[string] with values and filterFunc");

  Json[string] map = [
    "a": true.toJson,
    "b": "not a boolean".toJson,
    "c": false.toJson,
    "d": 42.toJson
  ];

  auto filtered1 = map.filterBooleans([true.toJson, false.toJson]);
  assert(filtered1.length == 2);

  auto filtered2 = map.filterBooleans((Json json) @safe => json.toBoolean == false);
  assert(filtered2.length == 1);

  auto filtered = map.filterBooleans([true.toJson, false.toJson], (Json json) @safe => json.toBoolean == false);
  assert(filtered.length == 1);
  assert(filtered["c"] == false.toJson);
}

Json[string] filterBooleans(Json[string] map, string[] keys) {
  return map.filterKeys(keys).filterBooleans;
}
/// 
unittest {
  version (test_uim_root) writeln("Testing filterBooleans for Json[string] with keys");

  Json[string] map = [
    "a": true.toJson,
    "b": "not a boolean".toJson,
    "c": false.toJson,
    "d": 42.toJson
  ];
  auto filtered = map.filterBooleans(["a", "c"]);
  assert(filtered.length == 2);
  assert(filtered["a"] == true.toJson);
  assert(filtered["c"] == false.toJson);
}

Json[string] filterBooleans(Json[string] map, Json[] values) {
  return map.filterValues(values).filterBooleans;
}
/// 
unittest {
  version (test_uim_root) writeln("Testing filterBooleans for Json[string] with values");

  Json[string] map = [
    "a": true.toJson,
    "b": "not a boolean".toJson,
    "c": false.toJson,
    "d": 42.toJson
  ];
  auto filtered = map.filterBooleans([true.toJson, false.toJson]);
  assert(filtered.length == 2);
  assert(filtered["a"] == true.toJson);
  assert(filtered["c"] == false.toJson);
}

Json[string] filterBooleans(Json[string] map, bool delegate(string) @safe filterFunc) {
  return map.filterMap((string key, Json json) => filterFunc(key)).filterBooleans;
}
/// 
unittest {
  version (test_uim_root) writeln("Testing filterBooleans for Json[string] with filterFunc");

  Json[string] map = [
    "a": true.toJson,
    "b": "not a boolean".toJson,
    "c": false.toJson,
    "d": 42.toJson
  ];
  auto filtered = map.filterBooleans((string key) @safe => key == "b");
  assert(filtered.length == 0);
}

Json[string] filterBooleans(Json[string] map, bool delegate(Json) @safe filterFunc) {
  return map.filterMap((string key, Json json) => filterFunc(json)).filterBooleans;
}
/// 
unittest {
  version (test_uim_root) writeln("Testing filterBooleans for Json[string] with filterFunc");

  Json[string] map = [
    "a": true.toJson,
    "b": "not a boolean".toJson,
    "c": false.toJson,
    "d": 42.toJson
  ];
  auto filtered = map.filterBooleans((Json json) @safe => json.toBoolean == true);
  assert(filtered.length == 1);
  assert(filtered["a"] == true.toJson);
}

Json[string] filterBooleans(Json[string] map, bool delegate(string, Json) @safe filterFunc) {
  return map.filterMap((string key, Json json) => filterFunc(key, json)).filterBooleans;
}
/// 
unittest {
  version (test_uim_root) writeln("Testing filterBooleans for Json[string] with filterFunc");

  Json[string] map = [
    "a": true.toJson,
    "b": "not a boolean".toJson,
    "c": false.toJson,
    "d": 42.toJson
  ];
  auto filtered = map.filterBooleans((string key, Json json) @safe => key == "c" && json.isBoolean);
  assert(filtered.length == 1);
  assert(filtered["c"] == false.toJson);
}

Json[string] filterBooleans(Json[string] map) {
  return map.filterMap((string key, Json json) => json.isBoolean);
}
/// 
unittest {
  version (test_uim_root) writeln("Testing filterBooleans for Json[string]");

  Json[string] map = [
    "a": true.toJson,
    "b": "not a boolean".toJson,
    "c": false.toJson,
    "d": 42.toJson
  ];
  auto filtered = map.filterBooleans;
  assert(filtered.length == 2);
  assert(filtered["a"] == true.toJson);
  assert(filtered["c"] == false.toJson);
}
// #region Json[string]

// #region Json
Json filterBooleans(Json json, size_t[] indices, bool delegate(Json) @safe filterFunc) {
  return json.isBoolean ? json.filterBooleans(indices).filterBooleans(filterFunc) : Json(null);
}
/// 
unittest {
  version (test_uim_root) writeln("Testing filterBooleans for Json with indices and filterFunc");

  Json json = [true.toJson, "not a boolean".toJson, false.toJson, 42.toJson].toJson;

  auto filtered1 = json.filterBooleans([0, 2]);
  assert(filtered1.isArray);
  assert(filtered1.toArray.length == 2);

  auto filtered2 = json.filterBooleans((Json j) @safe => j.isBoolean && j.toBool == true);
  assert(filtered2.isArray);
  assert(filtered2.toArray.length == 1);

  auto filtered = json.filterBooleans([0, 2], (Json j) @safe => j.isBoolean && j.toBool == true);
  assert(filtered.isArray);
  assert(filtered.toArray.length == 1);
  assert(filtered.toArray[0] == true.toJson);
}

Json filterBooleans(Json json, size_t[] indices) {
  return json.isBoolean ? json.toArray.filterValues(indices).filterBooleans.toJson : Json(null);
}
/// 
unittest {
  version (test_uim_root) writeln("Testing filterBooleans for Json with indices");

  Json json = [true.toJson, "not a boolean".toJson, false.toJson, 42.toJson].toJson;
  auto filtered = json.filterBooleans([0, 1, 2]);
  assert(filtered.isArray);
  assert(filtered.toArray.length == 2);
  assert(filtered.toArray[0] == true.toJson);
  assert(filtered.toArray[1] == false.toJson);
}

Json filterBooleans(Json json, bool delegate(Json) @safe filterFunc) {
  return json.isBoolean ? json.filterValues((Json json) => filterFunc(json)).filterBooleans : Json(null);
}
/// 
unittest {
  version (test_uim_root) writeln("Testing filterBooleans for Json with filterFunc");

  Json json = [true.toJson, "not a boolean".toJson, false.toJson, 42.toJson].toJson;
  auto filtered = json.filterBooleans((Json j) @safe => j.toBool == false);
  assert(filtered.isArray);
  assert(filtered.toArray.length == 1);
  assert(filtered.toArray[0] == false.toJson);
}

Json filterBooleans(Json json) {
  return json.isObject ? json.filterValues((Json json) => json.isBoolean) : Json(null);
}
// #region Json

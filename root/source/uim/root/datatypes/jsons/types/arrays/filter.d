module uim.root.datatypes.jsons.types.arrays.filter;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

// #region Json[]
Json[] filterArrays(Json[] jsons, size_t[] indices, bool delegate(Json json) @safe filterFunc) {
  return jsons.filterValues(indices).filterArrays;
}
/// 
unittest {
  version (test_uim_root) writeln("Testing filterArrays for Json[] with indices and filterFunc");

  Json[] jsons = [[1, 2, 3].toJson, "not an array".toJson, [4, 5].toJson, 42.toJson];

  auto filtered1 = jsons.filterArrays([0, 2]);
  assert(filtered1.length == 2);

  auto filtered2 = jsons.filterArrays((Json json) @safe => json.isArray && json.length > 2);
  assert(filtered2.length == 1);

  auto filtered = jsons.filterArrays([0, 2], (Json json) @safe => json.isArray && json.length > 2);
  assert(filtered.length == 2);
  assert(filtered[0] == [1, 2, 3].toJson);
}

Json[] filterArrays(Json[] jsons, size_t[] indices) {
  return jsons.filterValues(indices).filterArrays;
}
/// 
unittest {  
  version (test_uim_root) writeln("Testing filterArrays for Json[] with indices");

  Json[] jsons = [[1, 2, 3].toJson, "not an array".toJson, [4, 5].toJson, 42.toJson];
  auto filtered = jsons.filterArrays([0, 1, 2]);
  assert(filtered.length == 2);
  assert(filtered[0] == [1, 2, 3].toJson);
  assert(filtered[1] == [4, 5].toJson);
}

Json[] filterArrays(Json[] jsons, bool delegate(Json json) @safe filterFunc) {
  return jsons.filterArrays.filterValues((Json json) => filterFunc(json));
}
/// 
unittest {
  version (test_uim_root) writeln("Testing filterArrays for Json[] with filterFunc");

  Json[] jsons = [[1, 2, 3].toJson, "not an array".toJson, [4, 5].toJson, 42.toJson];
  auto filtered = jsons.filterArrays((Json json) @safe => json.length == 2);
  assert(filtered.length == 1);
  assert(filtered[0] == [4, 5].toJson);
}

Json[] filterArrays(Json[] jsons) {
  return jsons.filterValues((Json json) => json.isArray);
}/// 
unittest {
  version (test_uim_root) writeln("Testing filterArrays for Json[]");

  Json[] jsons = [[1, 2, 3].toJson, "not an array".toJson, [4, 5].toJson, 42.toJson];
  auto filtered = jsons.filterArrays();
  assert(filtered.length == 2);
  assert(filtered[0] == [1, 2, 3].toJson);
  assert(filtered[1] == [4, 5].toJson);
}
// #endregion Json[]

// #region Json[string]
Json[string] filterArrays(Json[string] map, string[] keys, bool delegate(string) @safe filterFunc) {
  return map.filterKeys(keys, filterFunc).filterArrays;
}
/// 
unittest {
  version (test_uim_root) writeln("Testing filterArrays for Json[string] with keys and filterFunc");

  Json[string] map = [
    "a": [1, 2, 3].toJson,
    "b": ["x", "y"].toJson,
    "c": "not an array".toJson,
    "d": 42.toJson
  ];
  auto filtered = map.filterArrays(["a", "c"], (string key) @safe => key == "a");
  assert(filtered.length == 1);
  assert(filtered["a"] == [1, 2, 3].toJson);
}

Json[string] filterArrays(Json[string] map, string[] keys) {
  return map.filterKeys(keys).filterArrays;
}
/// 
unittest {
  version (test_uim_root) writeln("Testing filterArrays for Json[string] with keys");

  Json[string] map = [
    "a": [1, 2, 3].toJson,
    "b": ["x", "y"].toJson,
    "c": "not an array".toJson,
    "d": 42.toJson
  ];
  auto filtered = map.filterArrays(["a", "c"]);
  assert(filtered.length == 1);
  assert(filtered["a"] == [1, 2, 3].toJson);
}

Json[string] filterArrays(Json[string] map, bool delegate(string, Json) @safe filterFunc) {
  return map.filterMap((string key, Json json) => filterFunc(key, json)).filterArrays;
}
/// 
unittest {
  version (test_uim_root) writeln("Testing filterArrays for Json[string] with filterFunc");

  Json[string] map = [
    "a": [1, 2, 3].toJson,
    "b": ["x", "y"].toJson,
    "c": "not an array".toJson,
    "d": 42.toJson
  ];
  auto filtered = map.filterArrays((string key, Json json) @safe => key == "b" && json.isArray);
  assert(filtered.length == 1);
  assert(filtered["b"] == ["x", "y"].toJson);
}

Json[string] filterArrays(Json[string] map) {
  return map.filterMap((string key, Json json) => json.isArray);
}
/// 
unittest {
  version (test_uim_root) writeln("Testing filterArrays for Json[string]");

  Json[string] map = [
    "a": [1, 2, 3].toJson,
    "b": ["x", "y"].toJson,
    "c": "not an array".toJson,
    "d": 42.toJson
  ];
  auto filtered = map.filterArrays();
  assert(filtered.length == 2);
  assert(filtered["a"] == [1, 2, 3].toJson);
  assert(filtered["b"] == ["x", "y"].toJson);
}
// #endregion Json[string]

// #region Json
Json filterArrays(Json json, size_t[] indices, bool delegate(Json json) @safe filterFunc) {
  return json.isArray ? json.filterArrays(indices).filterArrays(filterFunc) : Json(null);
}
/// 
unittest {
  version (test_uim_root) writeln("Testing filterArrays with indices and filterFunc");

  Json json = [[1, 2, 3].toJson, "not an array".toJson, [4, 5].toJson, 42.toJson].toJson;
  auto filtered = json.filterArrays([0, 2], (Json j) @safe => j.length > 2);
  assert(filtered.isArray);
  assert(filtered.length == 1);
  assert(filtered[0] == [1, 2, 3].toJson);
}

Json filterArrays(Json json, size_t[] indices) {
  return json.isArray ? json.toArray.filterValues(indices).filterArrays.toJson : Json(null);
}
/// 
unittest {
  version (test_uim_root) writeln("Testing filterArrays with indices");

  Json json = [[1, 2, 3].toJson, "not an array".toJson, [4, 5].toJson, 42.toJson].toJson;
  auto filtered = json.filterArrays([0, 1, 2]);
  assert(filtered.isArray);
  assert(filtered.length == 2);
  assert(filtered[0] == [1, 2, 3].toJson);
  assert(filtered[1] == [4, 5].toJson);
}

Json filterArrays(Json json, bool delegate(Json json) @safe filterFunc) {
  return json.isArray ? json.filterArrays.filterValues((Json json) => filterFunc(json)) : Json(null);
}
/// 
unittest {
  version (test_uim_root) writeln("Testing filterArrays with filterFunc");

  Json json = [[1, 2, 3].toJson, "not an array".toJson, [4, 5].toJson, 42.toJson].toJson;
  auto filtered = json.filterArrays((Json j) @safe => j.length == 2);
  assert(filtered.isArray);
  assert(filtered.length == 1);
  assert(filtered[0] == [4, 5].toJson);
}

/* 
Json filterArrays(Json json, string[] keys, bool delegate(string) @safe filterFunc) {
  return json.isObject ? json.filterKeys(keys)
    .filterValues((string key) => filterFunc(key)).filterArrays : Json(null);
}

Json filterArrays(Json json, string[] keys, bool delegate(Json) @safe filterFunc) {
  return json.isObject ? json.filterKeys(keys)
    .filterValues((Json json) => filterFunc(json)).filterArrays : Json(null);
}
* / 

Json filterArrays(Json json, bool delegate(string, Json) @safe filterFunc) {
  return json.isObject ? json.filterValues((string key, Json json) => filterFunc(key, json)).filterArrays
    : Json(null);
} */

Json filterArrays(Json json) {
  return json.isObject || json.isArray ? json.filterValues((Json json) => json.isArray) : Json(null);
}
// #endregion Json

/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.types.arrays.filter;

import uim.root;

mixin(ShowModule!());

@safe:

// #region Json[]
// #region indices
// #region with indices and filterFunc
Json[] filterArrays(Json[] jsons, size_t[] indices, bool delegate(size_t) @safe filterFunc) {
  return jsons.filterIndices(indices, filterFunc).filterArrays;
}
/// 
unittest {
  mixin(ShowTest!"Testing filterArrays for Json[] with indices and filterFunc");

  Json[] jsons = [
    [1, 2, 3].toJson, "not an array".toJson, [4, 5].toJson, 42.toJson
  ];

  auto filtered = jsons.filterArrays([0, 2, 3],
    (size_t index) @safe => jsons.isArray(index) && jsons[index].length > 2);
  assert(filtered.length == 1);
  assert(filtered[0] == [1, 2, 3].toJson);
}
// #endregion with indices and filterFunc

// #region with indices
Json[] filterArrays(Json[] jsons, size_t[] indices) {
  return jsons.filterIndices(indices).filterArrays;

}
/// 
unittest {
  mixin(ShowTest!"Testing filterArrays for Json[] with indices");

  Json[] jsons = [
    [1, 2, 3].toJson, "not an array".toJson, [4, 5].toJson, 42.toJson
  ];

  auto filtered = jsons.filterArrays([0, 2]);
  assert(filtered.length == 2);
  assert(filtered[0] == [1, 2, 3].toJson);
  assert(filtered[1] == [4, 5].toJson);
}
// #endregion with indices

// #region with filterFunc
Json[] filterArrays(Json[] jsons, bool delegate(size_t) @safe filterFunc) {
  return jsons.filterIndices(filterFunc).filterArrays;
}
///
unittest {
  mixin(ShowTest!"Testing filterArrays for Json[] with filterFunc");

  Json[] jsons = [
    [1, 2, 3].toJson, "not an array".toJson, [4, 5].toJson, 42.toJson
  ];

  auto filtered = jsons.filterArrays(
    (size_t index) @safe => jsons.isArray(index) && jsons[index].length == 2);
  assert(filtered.length == 1);
  assert(filtered[0] == [4, 5].toJson);
}
// #endregion with filterFunc
// #endregion indices

// #region values
// #region with values and filterFunc
Json[] filterArrays(Json[] jsons, Json[] values, bool delegate(Json) @safe filterFunc) {
  return jsons.filterValues(values, filterFunc).filterArrays;
}
/// 
unittest {
  mixin(ShowTest!"Testing filterIndices for Json[] with values and filterFunc");

  Json[] jsons = [
    [1, 2, 3].toJson, "not an array".toJson, [4, 5].toJson, 42.toJson
  ];
  auto filtered = jsons.filterArrays(
    [[1, 2, 3].toJson, ["x", "y"].toJson],
    (Json j) @safe => j.length > 2);
  assert(filtered.length == 1);
  assert(filtered[0] == [1, 2, 3].toJson);
}
// #endregion with values and filterFunc

// #region with filterFunc
Json[] filterArrays(Json[] jsons, bool delegate(Json) @safe filterFunc) {
  return filterValues(jsons, filterFunc).filterArrays;
}
/// 
unittest {
  mixin(ShowTest!"Testing filterArrays for Json[] with filterFunc");

  Json[] jsons = [
    [1, 2, 3].toJson, "not an array".toJson, [4, 5].toJson, 42.toJson
  ];
  auto filtered = jsons.filterArrays(
    (Json j) @safe => j.isArray && j.length == 2);
  assert(filtered.length == 1);
  assert(filtered[0] == [4, 5].toJson);
}
// #endregion with filterFunc

// #region by values
Json[] filterArrays(Json[] jsons, Json[] values) {
  return jsons.filterValues(values).filterArrays;
} /// 
unittest {
  mixin(ShowTest!"Testing filterArrays for Json[] with values");

  Json[] jsons = [
    [1, 2, 3].toJson, "not an array".toJson, [4, 5].toJson, 42.toJson
  ];
  auto filtered = jsons.filterArrays(
    [[1, 2, 3].toJson, ["x", "y"].toJson]);
  assert(filtered.length == 1);
  assert(filtered[0] == [1, 2, 3].toJson);
}
// #endregion by values

// #region by datatype
Json[] filterArrays(Json[] jsons) {
  if (jsons.length == 0) {
    return null;
  }

  return jsons.filter!(json => json.isArray).array;
}
/// 
unittest {
  mixin(ShowTest!"Testing filterArrays for Json[] by datatype");

  Json[] jsons = [
    [1, 2, 3].toJson, "not an array".toJson, [4, 5].toJson, 42.toJson
  ];
  auto filtered = jsons.filterArrays;
  assert(filtered.length == 2);
  assert(filtered[0] == [1, 2, 3].toJson);
  assert(filtered[1] == [4, 5].toJson);
}
// #endregion by datatype
// #endregion values
// #endregion Json[]

// #region Json[string]
// #region paths
// #region with paths and filterFunc
Json[string] filterArrays(Json[string] map, string[][] paths, bool delegate(string[]) @safe filterFunc) {
  return map.filterPaths(paths, filterFunc).filterArrays;
}
/// 
unittest {
  mixin(ShowTest!"Testing filterArrays for Json[string] with paths and filterFunc");

  Json[string] map = [
    "a": [1, 2, 3].toJson,
    "b": ["x", "y"].toJson,
    "c": "not an array".toJson,
    "d": 42.toJson
  ];
  auto filtered = map.filterArrays([["a"], ["c"]], (string[] path) @safe => path[0] == "a");
  assert(filtered.length == 1);
  assert(filtered["a"] == [1, 2, 3].toJson);
}
// #endregion with paths and filterFunc

// #region with paths
Json[string] filterArrays(Json[string] map, string[][] paths) {
  return map.filterPaths(paths).filterArrays;
}
/// 
unittest {
  mixin(ShowTest!"Testing filterArrays for Json[string] with paths");

  Json[string] map = [
    "a": [1, 2, 3].toJson,
    "b": ["x", "y"].toJson,
    "c": "not an array".toJson,
    "d": 42.toJson
  ];
  auto filtered = map.filterArrays([["a"], ["c"]]);
  assert(filtered.length == 1);
  assert(filtered["a"] == [1, 2, 3].toJson);
}
// #endregion with paths
// #endregion paths

// #region keys
// #region with keys and filterFunc
Json[string] filterArrays(Json[string] map, string[] keys, bool delegate(string) @safe filterFunc) {
  return map.filterKeys(keys, filterFunc).filterArrays;
}
/// 
unittest {
  mixin(ShowTest!"Testing filterArrays for Json[string] with keys and filterFunc");

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
// #endregion with keys and filterFunc

// #region with keys
Json[string] filterArrays(Json[string] map, string[] keys) {
  return map.filterKeys(keys).filterArrays;
}
/// 
unittest {
  mixin(ShowTest!"Testing filterArrays for Json[string] with keys");

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
// #endregion with keys

// #region with filterFunc
Json[string] filterArrays(Json[string] map, bool delegate(string) @safe filterFunc) {
  if (map.length == 0) {
    return null;
  }

  Json[string] result;
  foreach (key; map.keys) {
    if (filterFunc(key)) {
      result[key] = map[key];
    }
  }

  return result;
}
/// 
unittest {
  mixin(ShowTest!"Testing filterArrays for Json[string] with filterFunc");

  Json[string] map = [
    "a": [1, 2, 3].toJson,
    "b": ["x", "y"].toJson,
    "c": "not an array".toJson,
    "d": 42.toJson
  ];
  auto filtered = map.filterArrays((string key) @safe => key == "b");
  assert(filtered.length == 1);
  assert(filtered["b"] == ["x", "y"].toJson);
}
// #endregion with filterFunc
// #endregion keys

// #region values
// #region with values and filterFunc
Json[string] filterArrays(Json[string] map, Json[] values, bool delegate(Json) @safe filterFunc) {
  return map.filterValues(values, filterFunc).filterArrays;
}
/// 
unittest {
  mixin(ShowTest!"Testing filterArrays for Json[string] with values and filterFunc");

  Json[string] map = [
    "a": [1, 2, 3].toJson,
    "b": ["x", "y"].toJson,
    "c": "not an array".toJson,
    "d": 42.toJson
  ];
  auto filtered = map.filterArrays(
    [[1, 2, 3].toJson, ["x", "y"].toJson],
    (Json json) @safe => json.length > 2);
  assert(filtered.length == 1);
  assert(filtered["a"] == [1, 2, 3].toJson);
}
// #endregion with values and filterFunc

// #region with values
Json[string] filterArrays(Json[string] map, Json[] values) {
  return map.filterValues(values).filterArrays;
}
/// 
unittest {
  mixin(ShowTest!"Testing filterArrays for Json[string] with values");

  Json[string] map = [
    "a": [1, 2, 3].toJson,
    "b": ["x", "y"].toJson,
    "c": "not an array".toJson,
    "d": 42.toJson
  ];
  auto filtered = map.filterArrays(
    [[1, 2, 3].toJson, ["x", "y"].toJson]);
  assert(filtered.length == 2);
  assert(filtered["a"] == [1, 2, 3].toJson);
  assert(filtered["b"] == ["x", "y"].toJson);
}
// #endregion with values

// #region with filterFunc
Json[string] filterArrays(Json[string] map, bool delegate(Json) @safe filterFunc) {
  return map.filterValues(filterFunc).filterArrays;
}
/// 
unittest {
  mixin(ShowTest!"Testing filterArrays for Json[string] with filterFunc");

  Json[string] map = [
    "a": [1, 2, 3].toJson,
    "b": ["x", "y"].toJson,
    "c": "not an array".toJson,
    "d": 42.toJson
  ];
  auto filtered = map.filterArrays((Json json) @safe => json.isArray && json.length == 2);
  assert(filtered.length == 1);
  assert(filtered["b"] == ["x", "y"].toJson);
}
// #endregion with filterFunc

// #region filter all arrays
Json[string] filterArrays(Json[string] map) {
  return map.filterValues((Json json) => json.isArray);
}
/// 
unittest {
  mixin(ShowTest!"Testing filterArrays for Json[string]");

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
// #endregion filter all arrays
// #endregion values
// #endregion Json[string]

// #region Json
// #region indices
// #region with indices and filterFunc
Json filterArrays(Json json, size_t[] indices, bool delegate(size_t) @safe filterFunc) {
  return json.filterIndices(indices, filterFunc).filterArrays;
}
/// 
unittest {
  mixin(ShowTest!"Testing filterArrays with indices and filterFunc");

  Json json = [
    [1, 2, 3].toJson, "not an array".toJson, [4, 5].toJson, 42.toJson
  ].toJson;
  auto filtered = json.filterArrays([0, 2, 3],
    (size_t index) @safe => json.isArray(index) && json[index].length > 2);
  assert(filtered.isArray);
  assert(filtered.length == 1);
  assert(filtered[0] == [1, 2, 3].toJson);
}
// #endregion with indices and filterFunc

// #region with indices
Json filterArrays(Json json, size_t[] indices) {
  return json.filterIndices(indices).filterArrays;
}
/// 
unittest {
  mixin(ShowTest!"Testing filterArrays with indices");

  Json json = [
    [1, 2, 3].toJson, "not an array".toJson, [4, 5].toJson, 42.toJson
  ].toJson;
  auto filtered = json.filterArrays([0, 1, 2]);
  assert(filtered.isArray);
  assert(filtered.length == 2);
  assert(filtered[0] == [1, 2, 3].toJson);
  assert(filtered[1] == [4, 5].toJson);
}
// #endregion with indices

// #region with filterFunc
Json filterArrays(Json json, bool delegate(size_t) @safe filterFunc) {
  return json.isArray ? json.filterIndices(filterFunc) : Json(null);
}
/// 
unittest {
  mixin(ShowTest!"Testing filterArrays with filterFunc");

  Json json = [
    [1, 2, 3].toJson, "not an array".toJson, [4, 5].toJson, 42.toJson
  ].toJson;
  auto filtered = json.filterArrays(
    (size_t index) @safe => json.isArray(index) && json[index].length == 2);
  assert(filtered.isArray);
  assert(filtered.length == 1);
  assert(filtered[0] == [4, 5].toJson);
}
// #endregion with filterFunc
// #endregion indices

// #region values
// #region with values and filterFunc
Json filterArrays(Json json, Json[] values, bool delegate(Json) @safe filterFunc) {
  return json.filterValues(values, filterFunc).filterArrays;
}
/// 
unittest {
  mixin(ShowTest!"Testing filterArrays with values and filterFunc");

  Json json = [
    [1, 2, 3].toJson, "not an array".toJson, [4, 5].toJson, 42.toJson
  ].toJson;
  auto filtered = json.filterArrays(
    [[1, 2, 3].toJson, ["x", "y"].toJson],
    (Json j) @safe => j.length > 2);
  assert(filtered.isArray);
  assert(filtered.length == 1);
  assert(filtered[0] == [1, 2, 3].toJson);
}
// #endregion with values and filterFunc

// #region with filterFunc
Json filterArrays(Json json, bool delegate(Json) @safe filterFunc) {
  return json.filterValues(filterFunc).filterArrays;
}
/// 
unittest {
  mixin(ShowTest!"Testing filterArrays with filterFunc");

  Json json = [
    [1, 2, 3].toJson, "not an array".toJson, [4, 5].toJson, 42.toJson
  ].toJson;
  auto filtered = json.filterArrays((Json j) @safe => j.isArray && j.length == 2);
  assert(filtered.isArray);
  assert(filtered.length == 1);
  assert(filtered[0] == [4, 5].toJson);
}
// #endregion with filterFunc

// #region simple values
Json filterArrays(Json json) {
  return json.filterValues((Json json) => json.isArray);
}
/// 
unittest {
  mixin(ShowTest!"Testing filterArrays for Json by datatype");

  Json json = [
    [1, 2, 3].toJson, "not an array".toJson, [4, 5].toJson, 42.toJson
  ].toJson;
  auto filtered = json.filterArrays;
  assert(filtered.isArray);
  assert(filtered.length == 2);
  assert(filtered[0] == [1, 2, 3].toJson);
  assert(filtered[1] == [4, 5].toJson);
}
// #endregion simple values
// #endregion values
// #endregion Json


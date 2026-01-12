/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.types.objects.filter;

import uim.root;

mixin(ShowModule!());

@safe:

// #region Json[]
// #region indices
// #region filter with indices and filterFunc
Json[] filterObjects(Json[] jsons, size_t[] indices, bool delegate(size_t) @safe filterFunc) {
  return jsons.filterIndices(indices, filterFunc).filterObjects;
}
/// 
unittest {
  mixin(ShowTest!"Testing filterObjects for Json[] with indices and filterFunc");

  Json[] jsons = [
    true.toJson, "not an array".toJson, false.toJson, 42.toJson
  ];

  auto filtered = jsons.filterObjects([0, 2, 3],
    (size_t index) @safe => jsons[index].isObject);
    // TODO
  // assert(filtered.length == 2);
  // assert(filtered[0] == true.toJson);
  // assert(filtered[1] == false.toJson);
}
// #endregion filter with indices and filterFunc

// #region filter with indices
Json[] filterObjects(Json[] jsons, size_t[] indices) {
  return jsons.filterIndices(indices).filterObjects;
}
/// 
unittest {
  mixin(ShowTest!"Testing filterObjects for Json[] with indices");

  Json[] jsons = [
    true.toJson, "not an array".toJson, false.toJson, 42.toJson
  ];

  auto filtered = jsons.filterObjects([0, 1, 2]);
    // TODO
  // assert(filtered.length == 2);
  // assert(filtered[0] == true.toJson);
  // assert(filtered[1] == false.toJson);
}
// #endregion filter with indices

// #region with filterFunc
Json[] filterObjects(Json[] jsons, bool delegate(size_t) @safe filterFunc) {
  return jsons.filterIndices(filterFunc).filterObjects;
}
///
unittest {
  mixin(ShowTest!"Testing filterObjects for Json[] with filterFunc");

  Json[] jsons = [
    true.toJson, "not an array".toJson, false.toJson, 42.toJson
  ];

  auto filtered = jsons.filterObjects(
    (size_t index) @safe => jsons[index].isObject);
    // TODO
  // assert(filtered.length == 2);
  // assert(filtered[0] == true.toJson);
  // assert(filtered[1] == false.toJson);
}
// #endregion with filterFunc
// #endregion indices

// #region values
// #region filter with values and filterFunc
Json[] filterObjects(Json[] jsons, Json[] values, bool delegate(Json) @safe filterFunc) {
  return jsons.filterValues(values, filterFunc).filterObjects;
}
/// 
unittest {
  mixin(ShowTest!"Testing filterObjects for Json[] with values and filterFunc");

  Json[] jsons = [
    true.toJson, "not an array".toJson, false.toJson, 42.toJson
  ];
  auto filtered = jsons.filterObjects(
    [true.toJson, ["x", "y"].toJson],
    (Json json) @safe => json == Json(true));
    // TODO
  // assert(filtered.length == 2);
  // assert(filtered[0] == true.toJson);
  // assert(filtered[1] == false.toJson);
}
// #endregion filter with values and filterFunc

// #region with filterFunc
Json[] filterObjects(Json[] jsons, bool delegate(Json) @safe filterFunc) {
  return filterValues(jsons, filterFunc).filterObjects;
}
/// 
unittest {
  mixin(ShowTest!"Testing filterObjects for Json[] with filterFunc");

  Json[] jsons = [
    true.toJson, "not an array".toJson, false.toJson, 42.toJson
  ];
  auto filtered = jsons.filterObjects((Json j) @safe => j.isObject);
    // TODO
  // assert(filtered.length == 2);
  // assert(filtered[0] == true.toJson);
  // assert(filtered[1] == false.toJson);
}
// #endregion with filterFunc

// #region by values
Json[] filterObjects(Json[] jsons, Json[] values) {
  return jsons.filterValues(values).filterObjects;
} /// 
unittest {
  mixin(ShowTest!"Testing filterObjects for Json[] by values");

  Json[] jsons = [
    true.toJson, "not an array".toJson, false.toJson, 42.toJson
  ];
  auto filtered = jsons.filterObjects(
    [true.toJson, ["x", "y"].toJson]);
    // TODO
  // assert(filtered.length == 2);
  // assert(filtered[0] == true.toJson);
  // assert(filtered[1] == false.toJson);
}
// #endregion by values

// #region by datatype
Json[] filterObjects(Json[] jsons) {
  if (jsons.length == 0) {
    return null;
  }

  return jsons.filter!(json => json.isObject).array;
}
/// 
unittest {
  mixin(ShowTest!"Testing filterObjects for Json[] by datatype");

  Json[] jsons = [
    true.toJson, "not an array".toJson, false.toJson, 42.toJson
  ];
  auto filtered = jsons.filterObjects();
    // TODO
  // assert(filtered.length == 2);
  // assert(filtered[0] == true.toJson);
  // assert(filtered[1] == false.toJson);
}
// #endregion by datatype
// #endregion values
// #endregion Json[]

// #region Json[string]
// #region paths
// #region with paths and filterFunc
Json[string] filterObjects(Json[string] map, string[][] paths, bool delegate(string[]) @safe filterFunc) {
  return map.filterPaths(paths, filterFunc).filterObjects;
}
/// 
unittest {
  mixin(ShowTest!"Testing filterObjects for Json[string] with paths and filterFunc");

  Json[string] map = [
    "a": true.toJson,
    "b": ["x", "y"].toJson,
    "c": "not an array".toJson,
    "d": 42.toJson
  ];
  auto filtered = map.filterObjects([["a"], ["c"]],
    (string[] path) @safe => path.length == 1 && path[0] == "a");
    // TODO
  // assert(filtered.length == 2);
  // assert(filtered[0] == true.toJson);
  // assert(filtered[1] == false.toJson);
}
// #endregion with paths and filterFunc

// #region with paths
Json[string] filterObjects(Json[string] map, string[][] paths) {
  return map.filterPaths(paths).filterObjects;
}
/// 
unittest {
  mixin(ShowTest!"Testing filterObjects for Json[string] with paths");

  Json[string] map = [
    "a": true.toJson,
    "b": ["x", "y"].toJson,
    "c": "not an array".toJson,
    "d": 42.toJson
  ];
  auto filtered = map.filterObjects([["a"], ["c"]]);
    // TODO
  // assert(filtered.length == 2);
  // assert(filtered[0] == true.toJson);
  // assert(filtered[1] == false.toJson);
}
// #endregion with paths
// #endregion paths

// #region keys
// #region filter with keys and filterFunc
Json[string] filterObjects(Json[string] map, string[] keys, bool delegate(string) @safe filterFunc) {
  return map.filterKeys(keys, filterFunc).filterObjects;
}
/// 
unittest {
  mixin(ShowTest!"Testing filterObjects for Json[string] with keys and filterFunc");

  Json[string] map = [
    "a": true.toJson,
    "b": ["x", "y"].toJson,
    "c": "not an array".toJson,
    "d": 42.toJson
  ];
  auto filtered = map.filterObjects(
    ["a", "c"],
    (string key) @safe => key == "a");
    // TODO
  // assert(filtered.length == 2);
  // assert(filtered[0] == true.toJson);
  // assert(filtered[1] == false.toJson);
}
// #endregion filter with keys and filterFunc

// #region filter with keys
Json[string] filterObjects(Json[string] map, string[] keys) {
  return map.filterKeys(keys).filterObjects;
}
/// 
unittest {
  mixin(ShowTest!"Testing filterObjects for Json[string] with keys");

  Json[string] map = [
    "a": true.toJson,
    "b": ["x", "y"].toJson,
    "c": "not an array".toJson,
    "d": 42.toJson
  ];
  auto filtered = map.filterObjects(
    ["a", "c"]);
    // TODO
  // assert(filtered.length == 2);
  // assert(filtered[0] == true.toJson);
  // assert(filtered[1] == false.toJson);
}
// #endregion filter with keys

// #region with filterFunc
Json[string] filterObjects(Json[string] map, bool delegate(string) @safe filterFunc) {
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
  mixin(ShowTest!"Testing filterObjects for Json[string] with filterFunc");

  Json[string] map = [
    "a": true.toJson,
    "b": ["x", "y"].toJson,
    "c": "not an array".toJson,
    "d": 42.toJson
  ];
  auto filtered = map.filterObjects((string key) @safe => key == "b");
    // TODO
  // assert(filtered.length == 2);
  // assert(filtered[0] == true.toJson);
  // assert(filtered[1] == false.toJson);
}
// #endregion with filterFunc
// #endregion keys

// #region values
// #region filter with values and filterFunc
Json[string] filterObjects(Json[string] map, Json[] values, bool delegate(Json) @safe filterFunc) {
  return map.filterValues(values, filterFunc).filterObjects;
}
/// 
unittest {
  mixin(ShowTest!"Testing filterObjects for Json[string] with values and filterFunc");

  Json[string] map = [
    "a": true.toJson,
    "b": ["x", "y"].toJson,
    "c": "not an array".toJson,
    "d": 42.toJson
  ];
  auto filtered = map.filterObjects(
    [true.toJson, ["x", "y"].toJson],
    (Json json) @safe => json.isObject);
    // TODO
  // assert(filtered.length == 2);
  // assert(filtered[0] == true.toJson);
  // assert(filtered[1] == false.toJson);
}
// #endregion filter with values and filterFunc

// #region filter with values
Json[string] filterObjects(Json[string] map, Json[] values) {
  return map.filterValues(values).filterObjects;
}
/// 
unittest {
  mixin(ShowTest!"Testing filterObjects for Json[string] with values");

  Json[string] map = [
    "a": true.toJson,
    "b": ["x", "y"].toJson,
    "c": "not an array".toJson,
    "d": 42.toJson
  ];
  auto filtered = map.filterObjects(
    [true.toJson, ["x", "y"].toJson]);
    // TODO
  // assert(filtered.length == 2);
  // assert(filtered[0] == true.toJson);
  // assert(filtered[1] == false.toJson);
}
// #endregion filter with values

// #region filter with filterFunc
Json[string] filterObjects(Json[string] map, bool delegate(Json) @safe filterFunc) {
  return map.filterValues(filterFunc).filterObjects;
}
/// 
unittest {
  mixin(ShowTest!"Testing filterObjects for Json[string] with filterFunc");

  Json[string] map = [
    "a": true.toJson,
    "b": ["x", "y"].toJson,
    "c": "not an array".toJson,
    "d": 42.toJson
  ];
  auto filtered = map.filterObjects((Json j) @safe => j.isObject);
    // TODO
  // assert(filtered.length == 2);
  // assert(filtered[0] == true.toJson);
  // assert(filtered[1] == false.toJson);
}
// #endregion filter with filterFunc

// #region filter all arrays
Json[string] filterObjects(Json[string] map) {
  return map.filterValues((Json json) => json.isObject);
}
/// 
unittest {
  mixin(ShowTest!"Testing filterObjects for Json[string] all arrays");

  Json[string] map = [
    "a": true.toJson,
    "b": ["x", "y"].toJson,
    "c": "not an array".toJson,
    "d": 42.toJson
  ];
  auto filtered = map.filterObjects();
    // TODO
  // assert(filtered.length == 2);
  // assert(filtered[0] == true.toJson);
  // assert(filtered[1] == false.toJson);
}
// #endregion filter all arrays
// #endregion values
// #endregion Json[string]

// #region Json
// #region indices
// #region with indices and filterFunc
Json filterObjects(Json json, size_t[] indices, bool delegate(size_t) @safe filterFunc) {
  return json.filterIndices(indices, filterFunc).filterObjects;
}
/// 
unittest {
  mixin(ShowTest!"Testing filterObjects with indices and filterFunc");

  Json json = [Json(1), Json(2), Json(3), Json(4), Json(5)].toJson;

  auto filtered = json.filterObjects([0, 2, 4],
    (size_t index) @safe => json[index].isObject);
  assert(filtered.length == 0);
}
// #endregion with indices and filterFunc

// #region with indices
Json filterObjects(Json json, size_t[] indices) {
  return json.filterIndices(indices).filterObjects;
}
/// 
unittest {
  mixin(ShowTest!"Testing filterObjects with indices");

  Json json = [Json(1), Json(2), Json(3), Json(4), Json(5)].toJson;

  auto filtered = json.filterObjects([0, 2, 4]);
    // TODO
  // assert(filtered.length == 2);
  // assert(filtered[0] == true.toJson);
  // assert(filtered[1] == false.toJson);
}
// #endregion with indices

// #region with filterFunc
Json filterObjects(Json json, bool delegate(size_t) @safe filterFunc) {
  return json.filterIndices(filterFunc);
}
/// 
unittest {
  mixin(ShowTest!"Testing filterObjects with filterFunc");

  Json json = [Json(1), Json(2), Json(3), Json(4), Json(5)].toJson;

  auto filtered = json.filterObjects(
    (size_t index) @safe => json[index].isObject);
    // TODO
  // assert(filtered.length == 2);
  // assert(filtered[0] == true.toJson);
  // assert(filtered[1] == false.toJson);
}
// #endregion with filterFunc
// #endregion indices

// #region values
// #region with values and filterFunc
Json filterObjects(Json json, Json[] values, bool delegate(Json) @safe filterFunc) {
  return json.filterValues(values, filterFunc).filterObjects;
}
/// 
unittest {
  mixin(ShowTest!"Testing filterObjects with values and filterFunc");

  Json json = [
    true.toJson, "not an array".toJson, false.toJson, 42.toJson
  ].toJson;
  auto filtered = json.filterObjects(
    [true.toJson, ["x", "y"].toJson],
    (Json json) @safe => json.isObject);
    // TODO
  // assert(filtered.length == 2);
  // assert(filtered[0] == true.toJson);
  // assert(filtered[1] == false.toJson);
}
// #endregion with values and filterFunc

// #region with filterFunc
Json filterObjects(Json json, bool delegate(Json) @safe filterFunc) {
  return json.filterValues(filterFunc).filterObjects;
}
/// 
unittest {
  mixin(ShowTest!"Testing filterObjects with filterFunc");

  Json json = [
    true.toJson, "not an array".toJson, false.toJson, 42.toJson
  ].toJson;
  auto filtered = json.filterObjects((Json j) @safe => j.isObject);
    // TODO
  // assert(filtered.length == 2);
  // assert(filtered[0] == true.toJson);
  // assert(filtered[1] == false.toJson);
}
// #endregion with filterFunc

// #region simple values
Json filterObjects(Json json) {
  return json.filterValues((Json json) => json.isObject);
}
/// 
unittest {
  mixin(ShowTest!"Testing filterObjects for Json by datatype");

  Json json = [
    true.toJson, "not an array".toJson, false.toJson, 42.toJson
  ].toJson;
  auto filtered = json.filterObjects();
    // TODO
  // assert(filtered.length == 2);
  // assert(filtered[0] == true.toJson);
  // assert(filtered[1] == false.toJson);
}
// #endregion simple values
// #endregion values
// #endregion Json


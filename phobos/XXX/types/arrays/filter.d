/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.types.arrays.filter;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

// #region Json[]
// #region filter with indices and filterFunc
Json[] filterArrays(Json[] jsons, size_t[] indices, bool delegate(Json) @safe filterFunc) {
  if (jsons.length == 0) {
    return jsons;
  }

  return jsons.filterValues(indices).filterArrays;
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing filterArrays for Json[] with indices and filterFunc");

  Json[] jsons = [
    [1, 2, 3].toJson, "not an array".toJson, [4, 5].toJson, 42.toJson
  ];

  auto filtered1 = jsons.filterArrays([0, 2]);
  assert(filtered1.length == 2);

  auto filtered2 = jsons.filterArrays((Json json) @safe => json.isArray && json.length > 2);
  assert(filtered2.length == 1);

  auto filtered = jsons.filterArrays([0, 2], (Json json) @safe => json.isArray && json.length > 2);
  assert(filtered.length == 2);
  assert(filtered[0] == [1, 2, 3].toJson);
}
// #endregion filter with indices and filterFunc

// #region filter with indices
Json[] filterArrays(Json[] jsons, size_t[] indices) {
  if (jsons.length == 0) {
    return jsons;
  }

  return jsons.filterValues(indices).filterArrays;
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing filterArrays for Json[] with indices");

  Json[] jsons = [
    [1, 2, 3].toJson, "not an array".toJson, [4, 5].toJson, 42.toJson
  ];
  auto filtered = jsons.filterArrays([0, 1, 2]);
  assert(filtered.length == 2);
  assert(filtered[0] == [1, 2, 3].toJson);
  assert(filtered[1] == [4, 5].toJson);
}
// #endregion filter with indices

// #region filter with filterFunc
Json[] filterArrays(Json[] jsons, bool delegate(Json) @safe filterFunc) {
  if (jsons.length == 0) {
    return jsons;
  }

  return jsons.filterArrays.filterValues((Json json) => filterFunc(json));
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing filterArrays for Json[] with filterFunc");

  Json[] jsons = [
    [1, 2, 3].toJson, "not an array".toJson, [4, 5].toJson, 42.toJson
  ];
  auto filtered = jsons.filterArrays((Json json) @safe => json.length == 2);
  assert(filtered.length == 1);
  assert(filtered[0] == [4, 5].toJson);
}
// #endregion filter with filterFunc

// #region filter all arrays
Json[] filterArrays(Json[] jsons) {
  if (jsons.length == 0) {
    return jsons;
  }

  return jsons.filterValues((Json json) => json.isArray);
} /// 
unittest {
  version (test_uim_root)
    writeln("Testing filterArrays for Json[]");

  Json[] jsons = [
    [1, 2, 3].toJson, "not an array".toJson, [4, 5].toJson, 42.toJson
  ];
  auto filtered = jsons.filterArrays();
  assert(filtered.length == 2);
  assert(filtered[0] == [1, 2, 3].toJson);
  assert(filtered[1] == [4, 5].toJson);
}
// #endregion filter all arrays
// #endregion Json[]

// #region Json[string]
// #region filter with keys and filterFunc
Json[string] filterArrays(Json[string] map, string[] keys, bool delegate(string) @safe filterFunc) {
  if (map.length == 0) {
    return map;
  }

  return map.filterKeys(keys, filterFunc).filterArrays;
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing filterArrays for Json[string] with keys and filterFunc");

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
// #endregion filter with keys and filterFunc

// #region filter with keys
Json[string] filterArrays(Json[string] map, string[] keys) {
  if (map.length == 0) {
    return map;
  }

  return map.filterKeys(keys).filterArrays;
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing filterArrays for Json[string] with keys");

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
// #endregion filter with keys

// #region filter with values and filterFunc
Json[string] filterArrays(Json[string] map, Json[] values, bool delegate(Json) @safe filterFunc) {
  if (map.length == 0) {
    return map;
  }

  return map.filterValues(values, filterFunc).filterArrays;
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing filterArrays for Json[string] with values and filterFunc");

  Json[string] map = [
    "a": [1, 2, 3].toJson,
    "b": ["x", "y"].toJson,
    "c": "not an array".toJson,
    "d": 42.toJson
  ];
  auto filtered = map.filterArrays(["a".toJson, "c".toJson], (Json j) @safe => j.isArray);
  assert(filtered.length == 1);
  assert(filtered["a"] == [1, 2, 3].toJson);
}
// #endregion filter with values and filterFunc

// #region filter with values
Json[string] filterArrays(Json[string] map, Json[] values) {
  if (map.length == 0) {
    return map;
  }

  return map.filterValues(values).filterArrays;
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing filterArrays for Json[string] with values");

  Json[string] map = [
    "a": [1, 2, 3].toJson,
    "b": ["x", "y"].toJson,
    "c": "not an array".toJson,
    "d": 42.toJson
  ];
  auto filtered = map.filterArrays(["a".toJson, "c".toJson]);
  assert(filtered.length == 1);
  assert(filtered["a"] == [1, 2, 3].toJson);
}
// #endregion filter with keys

// #region filter with filterFunc
Json[string] filterArrays(Json[string] map, bool delegate(string, Json) @safe filterFunc) {
  if (map.length == 0) {
    return map;
  }
  return map.filterMap((string key, Json json) => filterFunc(key, json)).filterArrays;
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing filterArrays for Json[string] with filterFunc");

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
// #endregion filter with filterFunc

// #region filter all arrays
Json[string] filterArrays(Json[string] map) {
  return map.filterMap((string key, Json json) => json.isArray);
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing filterArrays for Json[string]");

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
// #endregion Json[string]

// #region Json
Json filterArrays(Json json, size_t[] indices, bool delegate(Json) @safe filterFunc) {
  return json.isArray ? json.filterArrays(indices).filterArrays(filterFunc) : Json(null);
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing filterArrays with indices and filterFunc");

  Json json = [
    [1, 2, 3].toJson, "not an array".toJson, [4, 5].toJson, 42.toJson
  ].toJson;
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
  version (test_uim_root)
    writeln("Testing filterArrays with indices");

  Json json = [
    [1, 2, 3].toJson, "not an array".toJson, [4, 5].toJson, 42.toJson
  ].toJson;
  auto filtered = json.filterArrays([0, 1, 2]);
  assert(filtered.isArray);
  assert(filtered.length == 2);
  assert(filtered[0] == [1, 2, 3].toJson);
  assert(filtered[1] == [4, 5].toJson);
}

Json filterArrays(Json json, bool delegate(Json) @safe filterFunc) {
  return json.isArray ? json.filterArrays.filterValues((Json json) => filterFunc(json)) : Json(null);
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing filterArrays with filterFunc");

  Json json = [
    [1, 2, 3].toJson, "not an array".toJson, [4, 5].toJson, 42.toJson
  ].toJson;
  auto filtered = json.filterArrays((Json j) @safe => j.length == 2);
  assert(filtered.isArray);
  assert(filtered.length == 1);
  assert(filtered[0] == [4, 5].toJson);
}

Json filterArrays(Json json) {
  return json.isObject || json.isArray ? json.filterValues((Json json) => json.isArray) : Json(null);
}
// #endregion Json

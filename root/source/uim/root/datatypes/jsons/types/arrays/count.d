module uim.root.datatypes.jsons.types.arrays.count;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

// #region Json
size_t countArrays(Json json, size_t[] indices, bool delegate(Json) @safe countFunc) {
  return json.isArray ? json.toArray.countArrays(indices, countFunc) : 0;
}

size_t countArrays(Json json, size_t[] indices) {
  return json.isArray ? indices.filter!(index => json.isArray(index)).array.length : 0;
}
/// 
unittest {
  version (test_uim_root) writeln("Testing countArrays with indices");

  auto j1 = [1, 2].toJson;
  auto j2 = ["a": 1].toJson;
  auto j3 = [3, 4].toJson;
  auto j4 = "string".toJson;
  auto j5 = 42.toJson;
  
  Json json = [
    j1, j2, j3, j4, j5  
  ];
  size_t count = countArrays(json, [0, 1, 2, 3, 4]);
  assert(count == 2);
}

size_t countArrays(Json json, string[][] paths) {
  return json.isObject ? paths.filter!(path => json.isArray(path)).array.length : 0;
}
/// 
unittest {
  version (test_uim_root) writeln("Testing countArrays with paths");
  
  Json json = [
    "first": [1, 2].toJson,
    "second": ["a": 1].toJson,
    "third": [3, 4].toJson,
    "fourth": "string".toJson
  ].toJson;
  size_t count = countArrays(json, [
      ["first"], ["second"], ["third"], ["fourth"]
    ]);
  assert(count == 2);
}

size_t countArrays(Json json, string[] keys) {
  return json.isObject ? keys.filter!(key => json.isArray(key)).array.length : 0;
}
/// 
unittest {
  Json json = [
    "first": [1, 2].toJson,
    "second": ["a": 1].toJson,
    "third": [3, 4].toJson,
    "fourth": "string".toJson
  ].toJson;
  size_t count = countArrays(json, ["first", "second", "third", "fourth"]);
  assert(count == 2);
}

size_t countArrays(Json json, bool delegate(string) @safe countFunc) {
  return json.isObject ? json.byKeyValue.filter!(kv => countFunc(kv.key)).array.length : 0;
}
/// 
unittest {
  Json json = [
    "first": [1, 2].toJson,
    "second": ["a": 1].toJson,
    "third": [3, 4].toJson,
    "fourth": "string".toJson
  ].toJson;
  size_t count = countArrays(json, (string key) => key.startsWith("t"));
  assert(count == 1);
}

size_t countArrays(Json json, bool delegate(Json) @safe countFunc) {
  if (json.isArray) {
    return json.byValue.filter!(value => countFunc(value)).array.length;
  }
  if (json.isObject) {
    return json.byKeyValue.filter!(kv => countFunc(kv.value)).array.length;
  }
  return 0;
}
/// 
unittest {
  Json json = [
    "first": [1, 2].toJson,
    "second": ["a": 1].toJson,
    "third": [3, 4].toJson,
    "fourth": "string".toJson
  ].toJson;
  size_t count = countArrays(json, (Json value) => value.isArray);
  assert(count == 2);
}

size_t countArrays(Json json, bool delegate(string, Json) @safe countFunc) {
  return json.isObject ? json.byKeyValue.filter!(kv => countFunc(kv.key, kv.value)).array.length : 0;
}
/// 
unittest {
  Json json = [
    "first": [1, 2].toJson,
    "second": ["a": 1].toJson,
    "third": [3, 4].toJson,
    "fourth": "string".toJson
  ].toJson;
  size_t count = countArrays(json, (string key, Json value) => key.startsWith("t") && value.isArray);
  assert(count == 1);
}
// #endregion Json[string]

// #region Json[]
// #region Json[] with indices and delegate
size_t countArrays(Json[] jsons, size_t[] indices, bool delegate(Json) @safe countFunc) {
  return indices.filter!(index => jsons.isArray(index) && countFunc(jsons[index])).array.length;
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing countArrays for Json[] with indices and delegate");

  Json[] jsons = [
    [1, 2].toJson, ["a": 1].toJson, [3, 4, 5].toJson, "string".toJson, 42.toJson
  ];

  assert(countArrays(jsons, [0, 1, 2, 3, 4], (Json json) => json.isArray) == 2,
    "Expected 2 arrays in the provided indices");
  assert(countArrays(jsons, [0, 1, 2, 3, 4], (Json json) => json.isArray && json.length == 2) == 1,
    "Expected 1 array of length 2 in the provided indices");
  assert(countArrays(jsons, [0, 1, 2, 3, 4], (Json json) => json.isArray && json.length > 2) == 1,
    "Expected 1 array of length greater than 2 in the provided indices");
  assert(countArrays(jsons, [0, 1, 2, 3, 4], (Json json) => json.isArray && json.length > 5) == 0,
    "Expected 0 arrays of length greater than 5 in the provided indices");
}
// #endregion Json[] with indices and delegate

// #region Json[] with indices
size_t countArrays(Json[] jsons, size_t[] indices) {
  return indices.filter!(index => jsons.isArray(index)).array.length;
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing countArrays for Json[] with indices");

  Json[] jsons = [
    [1, 2].toJson, ["a": 1].toJson, [3, 4].toJson, "string".toJson, 42.toJson
  ];

  assert(countArrays(jsons, [0, 1, 2, 3, 4]) == 2, "Expected 2 arrays in the provided indices");
  assert(countArrays(jsons, [0, 1]) == 1, "Expected 1 array in the provided indices");
  assert(countArrays(jsons, [3, 4]) == 0, "Expected 0 arrays in the provided indices");
}
// #endregion Json[] with indices

// #region Json[] with delegate
size_t countArrays(Json[] jsons, bool delegate(Json) @safe countFunc) {
  return jsons.filter!(json => json.isArray && countFunc(json)).array.length;
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing countArrays for Json[] with delegate");

  Json[] jsons = [
    [1, 2].toJson, ["a": 1].toJson, [3, 4, 5].toJson, "string".toJson, 42.toJson
  ];
  assert(countArrays(jsons, (Json json) => json.isArray) == 2, "Expected 2 arrays in the Json[]");
  assert(countArrays(jsons, (Json json) => json.isArray && json.length == 2) == 1, "Expected 1 array of length 2 in the Json[]");
  assert(countArrays(jsons, (Json json) => json.isArray && json.length > 2) == 1, "Expected 1 array in the Json[]");
  assert(countArrays(jsons, (Json json) => json.isArray && json.length > 5) == 0, "Expected 0 arrays in the Json[]");
}
// #endregion Json[] with delegate
// #endregion Json[]

// #region Json[string]
// #region paths
// #region Json[string] with paths and delegate
size_t countArrays(Json[string] map, string[][] paths, bool delegate(string[]) @safe countFunc) {
  return paths.filter!(path => map.isArray(path) && countFunc(path)).array.length;
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing countArrays for Json[string] with paths and delegate");

  Json[string] map = [
    "first": [1, 2].toJson, "second": ["a": 1].toJson, "third": [3, 4].toJson,
    "fourth": "string".toJson, "sixth": ["a": ["b": [3, 4].toJson].toJson].toJson
  ];
  size_t count = map.countArrays([["first"], ["second"], ["third"], ["fourth"]],
    (string[] path) => path.length == 1 && path[0] == "first");
  assert(count == 1, "Expected 1 array in the provided paths matching the delegate");
  assert(map.countArrays( [["first"], ["second"], ["third"], ["fourth"]],
    (string[] path) => path.length == 1 ) == 2, "Expected 2 arrays in the provided paths matching the delegate");
  assert(map.countArrays( [["first"], ["second"], ["third"], ["sixth", "a", "b"]],
    (string[] path) => path.length >= 1 ) == 3, "Expected 3 arrays in the provided paths matching the delegate");
}
// #endregion Json[string] with paths and delegate

// #region Json[string] with paths
size_t countArrays(Json[string] map, string[][] paths) {
  return paths.filter!(path => map.isArray(path)).array.length;
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing countArrays for Json[string] with paths");

  Json[string] map = [
    "first": [1, 2].toJson, "second": ["a": 1].toJson, "third": [3, 4].toJson,
    "fourth": "string".toJson
  ];
  size_t count = map.countArrays([["first"], ["second"], ["third"], ["fourth"]]);
  assert(count == 2, "Expected 2 arrays in the provided paths");
}
// #endregion Json[string] with paths
// #endregion paths

// #region keys
// #region Json[string] with keys and delegate
size_t countArrays(Json[string] map, string[] keys, bool delegate(string) @safe countFunc) {
  return keys.filter!(key => map.isArray(key) && countFunc(key)).array.length;
}
/// 
unittest {
  version (test_uim_root) writeln("Testing countArrays with keys and delegate");

  Json[string] map = [
    "first": [1, 2].toJson, "second": ["a": 1].toJson, "third": [3, 4].toJson,
    "fourth": "string".toJson
  ];
  size_t count = map.countArrays(["first", "second", "third", "fourth"],
    (string key) => key.startsWith("t"));
  assert(count == 1);
}
// #endregion Json[string] with keys and delegate

// #region Json[string] with keys
size_t countArrays(Json[string] map, string[] keys) {
  return keys.filter!(key => map.isArray(key)).array.length;
}
/// 
unittest {
  Json[string] map = [
    "first": [1, 2].toJson, "second": ["a": 1].toJson, "third": [3, 4].toJson,
    "fourth": "string".toJson
  ];
  size_t count = map.countArrays(["first", "second", "third", "fourth"]);
  assert(count == 2);
}
// #endregion Json[string] with keys

// #endregion Json[string] with delegate keys
size_t countArrays(Json[string] map, bool delegate(string) @safe countFunc) {
  return map.byKeyValue.filter!(kv => countFunc(kv.key)).array.length;
}
/// 
unittest {
  Json[string] map = [
    "first": [1, 2].toJson, "second": ["a": 1].toJson, "third": [3, 4].toJson,
    "fourth": "string".toJson
  ];
  size_t count = map.countArrays((string key) => key.startsWith("t"));
  assert(count == 1);
}
// #endregion Json[string] with delegate keys
// #endregion keys

// #region values
// #region Json[string] with values and delegate
size_t countArrays(Json[string] map, Json[] values, bool delegate(Json) @safe countFunc) {
  return map.byKeyValue.filter!(kv => values.hasValue(kv.value) && countFunc(kv.value)).array.length;
}
/// 
unittest {
  version (test_uim_root) writeln("Testing countArrays with values and delegate");

  Json[string] map = [
    "first": [1, 2].toJson, "second": ["a": 1].toJson, "third": [3, 4].toJson,
    "fourth": "string".toJson
  ];
  size_t count = map.countArrays(
    [[1, 2].toJson, [3, 4].toJson, "string".toJson],
    (Json value) => value.isArray);
  assert(count == 2);
}
// #endregion Json[string] with values and delegate

// #region Json[string] with values
size_t countArrays(Json[string] map, Json[] values) {
  return map.byKeyValue.filter!(kv => values.hasValue(kv.value)).array.length;
}
/// 
unittest {
  version (test_uim_root) writeln("Testing countArrays with values");

  Json[string] map = [
    "first": [1, 2].toJson, "second": ["a": 1].toJson, "third": [3, 4].toJson,
    "fourth": "string".toJson
  ];
  size_t count = map.countArrays(
    [[1, 2].toJson, [3, 4].toJson, "string".toJson]);
  assert(count == 3);
}
// #endregion Json[string] with values

// #region Json[string] with delegate 
size_t countArrays(Json[string] map, bool delegate(Json) @safe countFunc) {
  return map.byKeyValue.filter!(kv => countFunc(kv.value)).array.length;
}
/// 
unittest {
  Json[string] map = [
    "first": [1, 2].toJson, "second": ["a": 1].toJson, "third": [3, 4].toJson,
    "fourth": "string".toJson
  ];
  size_t count = map.countArrays((Json value) => value.isArray);
  assert(count == 2);
}
// #endregion Json[string] with delegate 
// #endregion values

// #region map
// #region key-value delegate
size_t countArrays(Json[string] map, bool delegate(string, Json) @safe countFunc) {
  return map.byKeyValue.filter!(kv => countFunc(kv.key, kv.value)).array.length;
}
/// 
unittest {
  Json[string] map = [
    "first": [1, 2].toJson, "second": ["a": 1].toJson, "third": [3, 4].toJson,
    "fourth": "string".toJson
  ];
  size_t count = map.countArrays((string key, Json value) => key.startsWith("t") && value.isArray);
  assert(count == 1);
}
// #endregion map
// #endregion key-value delegate
// #endregion Json[string]


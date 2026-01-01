module uim.root.datatypes.jsons.types.arrays.count;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

// #region Json[]
size_t countArrays(Json[] jsons, size_t[] indices) {
  return indices.filter!(index => jsons.isArray(index)).array.length;
}
/// 
unittest {
  Json[] jsons = [
    [1, 2].toJson, ["a": 1].toJson, [3, 4].toJson, "string".toJson, 42.toJson
  ];
  size_t count = countArrays(jsons, [0, 1, 2, 3, 4]);
  assert(count == 2);
}

size_t countArrays(Json[] jsons, bool delegate(Json) @safe countFunc) {
  return jsons.filter!(json => countFunc(json)).array.length;
}
/// 
unittest {
  Json[] jsons = [
    [1, 2].toJson, ["a": 1].toJson, [3, 4].toJson, "string".toJson, 42.toJson
  ];
  size_t count = countArrays(jsons, (Json json) => json.isArray);
  assert(count == 2);
}
// #endregion Json[]

// #region Json[string]
size_t countArrays(Json[string] map, string[][] paths) {
  return paths.filter!(path => map.isArray(path)).array.length;
}
/// 
unittest {
  Json[string] map = [
    "first": [1, 2].toJson, "second": ["a": 1].toJson, "third": [3, 4].toJson,
    "fourth": "string".toJson
  ];
  size_t count = countArrays(map, [["first"], ["second"], ["third"], ["fourth"]]);
  assert(count == 2);
}

size_t countArrays(Json[string] map, string[] keys) {
  return keys.filter!(key => map.isArray(key)).array.length;
}
/// 
unittest {
  Json[string] map = [
    "first": [1, 2].toJson, "second": ["a": 1].toJson, "third": [3, 4].toJson,
    "fourth": "string".toJson
  ];
  size_t count = countArrays(map, ["first", "second", "third", "fourth"]);
  assert(count == 2);
}

size_t countArrays(Json[string] map, bool delegate(string) @safe countFunc) {
  return map.byKeyValue.filter!(kv => countFunc(kv.key)).array.length;
}
/// 
unittest {
  Json[string] map = [
    "first": [1, 2].toJson, "second": ["a": 1].toJson, "third": [3, 4].toJson,
    "fourth": "string".toJson
  ];
  size_t count = countArrays(map, (string key) => key.startsWith("t"));
  assert(count == 1);
}

size_t countArrays(Json[string] map, bool delegate(Json) @safe countFunc) {
  return map.byKeyValue.filter!(kv => countFunc(kv.value)).array.length;
}
/// 
unittest {
  Json[string] map = [
    "first": [1, 2].toJson, "second": ["a": 1].toJson, "third": [3, 4].toJson,
    "fourth": "string".toJson
  ];
  size_t count = countArrays(map, (Json value) => value.isArray);
  assert(count == 2);
}

size_t countArrays(Json[string] map, bool delegate(string, Json) @safe countFunc) {
  return map.byKeyValue.filter!(kv => countFunc(kv.key, kv.value)).array.length;
}
/// 
unittest {
  Json[string] map = [
    "first": [1, 2].toJson, "second": ["a": 1].toJson, "third": [3, 4].toJson,
    "fourth": "string".toJson
  ];
  size_t count = countArrays(map, (string key, Json value) => key.startsWith("t") && value.isArray);
  assert(count == 1);
}
// #endregion Json[string]

// #region Json
size_t countArrays(Json json, size_t[] indices) {
  return json.isArray ? indices.filter!(index => json.isArray(index)).array.length : 0;
}
/// 
unittest {
  auto j1 = [1, 2].toJson;
  auto j2 = ["a": 1].toJson;
  auto j3 = [3, 4].toJson;
  auto j4 = "string".toJson;
  auto j5 = 42.toJson;
  
  Json json = [
    j1, j2, j3, j4, j5  
  ];
  size_t count = countArrays(json, [0, 1, 2, 3, 4]);
  writeln("Json: ", json);
  writeln("Counted arrays: ", count);
  assert(count == 2);
}

size_t countArrays(Json json, string[][] paths) {
  return json.isObject ? paths.filter!(path => json.isArray(path)).array.length : 0;
}
/// 
unittest {
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

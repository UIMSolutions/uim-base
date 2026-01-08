/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.types.arrays.typecheck;

import uim.root;

mixin(ShowModule!());

@safe:

// #region Json[]
// #region indices
// #region all
bool isAllArray(Json[] jsons, size_t[] indices = null) {
  return indices.length == 0
    ? jsons.length > 0 && jsons.all!(value => value.isArray) : indices.all!(
      index => jsons.isArray(index));
}
///
unittest {
  mixin(ShowTest!"Testing isAllArray for Json[] with indices");

  Json[] jsons = [[1, 2].toJson, ["a": 1].toJson, [3, 4].toJson];
  assert(isAllArray(jsons) == false);
  assert(isAnyArray(jsons) == true);
  assert(isAllArray(jsons, [0, 2]) == true);
  assert(isAnyArray(jsons, [1, 2]) == true);
}
// #endregion all

// #region any
bool isAnyArray(Json[] jsons, size_t[] indices = null) {
  return indices.length == 0
    ? jsons.length > 0 && jsons.any!(value => value.isArray) : indices.any!(
      index => jsons.isArray(index));
}
///
unittest {
  mixin(ShowTest!"Testing isAllArray and isAnyArray for Json[] with indices");

  Json[] jsons = [[1, 2].toJson, ["a": 1].toJson, [3, 4].toJson];
  assert(isAllArray(jsons) == false);
  assert(isAnyArray(jsons) == true);
  assert(isAllArray(jsons, [0, 2]) == true);
  assert(isAnyArray(jsons, [1, 2]) == true);
}
// #endregion any

// #region is
bool isArray(Json[] jsons, size_t index) {
  return jsons.length > index && jsons.getValue(index).isArray;
}
///
unittest {
  mixin(ShowTest!"Testing isArray for Json[]");
    
  Json[] jsons = [[1, 2].toJson, ["a": 1].toJson, [3, 4].toJson];
  assert(isAllArray(jsons) == false);
  assert(isAnyArray(jsons) == true);
  assert(isAllArray(jsons, [0, 2]) == true);
  assert(isAnyArray(jsons, [1, 2]) == true);
  assert(isArray(jsons, 0) == true);
  assert(isArray(jsons, 1) == false);
}
// #endregion is
// #endregion indices
// #endregion Json[]

// #region Json[string]
// #region paths
// #region all
bool isAllArray(Json[string] map, string[][] paths) {
  return map.length > 0 && paths.length > 0
    ? paths.all!(path => map.isArray(path)) : false;
}
///
unittest {
  mixin(ShowTest!"Testing isAllArray for Json[string] with paths");

  Json[string] map = [
    "arr1": [1, 2, 3].toJson,
    "obj1": ["key": "value"].toJson,
    "arr2": [4, 5].toJson
  ];

  assert(isAllArray(map, [["arr1"], ["arr2"]]));
  assert(!isAllArray(map, [["arr1"], ["obj1"]]));
}
// #endregion all

// #region any
bool isAnyArray(Json[string] map, string[][] paths) {
  return map.length > 0 && paths.length > 0
    ? paths.any!(path => map.isArray(path)) : false;
}
///
unittest {
  mixin(ShowTest!"Testing isAllArray and isAnyArray for Json[string] with paths");

  Json[string] map = [
    "arr1": [1, 2, 3].toJson,
    "obj1": ["key": "value"].toJson,
    "arr2": [4, 5].toJson
  ];

  assert(isAnyArray(map, [["obj1"], ["arr2"]]));
  assert(!isAnyArray(map, [["nonexistent1"], ["nonexistent2"]]));
}
// #endregion any

// #region is
bool isArray(Json[string] map, string[] path) {
  return map.length > 0 && path.length > 0 ? map.getValue(path).isArray : false;
}
///
unittest {
  mixin(ShowTest!"Testing isArray for Json[string] with path");

  Json[string] map = [
    "arr1": [1, 2, 3].toJson,
    "obj1": ["key": "value"].toJson,
    "arr2": [4, 5].toJson
  ];

  assert(isAllArray(map, ["arr1", "arr2"]));
  assert(!isAllArray(map, ["arr1", "obj1"]));
  assert(isAnyArray(map, ["obj1", "arr2"]));
  assert(!isAnyArray(map, ["nonexistent1", "nonexistent2"]));
  assert(isArray(map, ["arr1"]));
  assert(!isArray(map, ["obj1"]));
}
// #endregion is
// #endregion paths

// #region keys
// #region all
bool isAllArray(Json[string] map, string[] keys = null) {
  return keys.length > 0
    ? keys.all!(key => map.getValue(key)
        .isArray) : map.byValue.all!(value => value.isArray);
}
///
unittest {
  mixin(ShowTest!"Testing isAllArray for Json[string] with keys");

  Json[string] map = [
    "arr1": [1, 2, 3].toJson,
    "obj1": ["key": "value"].toJson,
    "arr2": [4, 5].toJson
  ];

  assert(isAllArray(map, ["arr1", "arr2"]));
  assert(!isAllArray(map, ["arr1", "obj1"]));
}
// #endregion all

// #region any
bool isAnyArray(Json[string] map, string[] keys = null) {
  return keys.length > 0
    ? keys.any!(key => map.getValue(key)
        .isArray) : map.byValue.any!(value => value.isArray);
}
///
unittest {
  mixin(ShowTest!"Testing isAllArray and isAnyArray for Json[string] with keys");

  Json[string] map = [
    "arr1": [1, 2, 3].toJson,
    "obj1": ["key": "value"].toJson,
    "arr2": [4, 5].toJson
  ];

  assert(isAllArray(map, ["arr1", "arr2"]));
  assert(!isAllArray(map, ["arr1", "obj1"]));
  assert(isAnyArray(map, ["obj1", "arr2"]));
  assert(!isAnyArray(map, ["nonexistent1", "nonexistent2"]));
}
// #endregion any

// #region is
bool isArray(Json[string] map, string key) {
  return map.getValue(key).isArray;
}
///
unittest {
  mixin(ShowTest!"Testing isArray for Json[string]");

  Json[string] map = [
    "arr1": [1, 2, 3].toJson,
    "obj1": ["key": "value"].toJson,
    "arr2": [4, 5].toJson
  ];

  assert(isAllArray(map, ["arr1", "arr2"]));
  assert(!isAllArray(map, ["arr1", "obj1"]));
  assert(isAnyArray(map, ["obj1", "arr2"]));
  assert(!isAnyArray(map, ["nonexistent1", "nonexistent2"]));
  assert(isArray(map, "arr1"));
  assert(!isArray(map, "obj1"));
}
// #endregion is
// #endregion keys
// #endregion Json[string]

// #region Json
// #region indices
// #region all
bool isAllArray(Json json, size_t[] indices) {
  return json.isArray && indices.length > 0
    ? indices.all!(index => json.isArray(index)) : false;
}
///
unittest {
  mixin(ShowTest!"Testing isAllArray for Json with indices");

  Json arr = [[1, 2].toJson, "not an array".toJson, [3, 4].toJson].toJson;
  assert(isAllArray(arr, [0, 2]));
  assert(!isAllArray(arr, [0, 1]));
}
// #endregion all

// #region any
bool isAnyArray(Json json, size_t[] indices) {
  return json.isArray && indices.length > 0
    ? indices.any!(index => json.isArray(index)) : false;
}
///
unittest {
  mixin(ShowTest!"Testing isAllArray and isAnyArray for Json with indices");

  Json arr = [[1, 2].toJson, "not an array".toJson, [3, 4].toJson].toJson;
  assert(isAllArray(arr, [0, 2]));
  assert(!isAllArray(arr, [0, 1]));
  assert(isAnyArray(arr, [1, 2]));
  assert(!isAnyArray(arr, [3, 4]));
}
// #endregion any

// #region is
bool isArray(Json json, size_t index) {
  return json.getValue(index).isArray;
}
///
unittest {
  mixin(ShowTest!"Testing isArray for Json with index");

  Json arr = [[1, 2].toJson, "not an array".toJson, [3, 4].toJson].toJson;
  assert(isAllArray(arr, [0, 2]));
  assert(!isAllArray(arr, [0, 1]));
  assert(isAnyArray(arr, [1, 2]));
  assert(!isAnyArray(arr, [3, 4]));
  assert(isArray(arr, 0));
  assert(!isArray(arr, 1));
  assert(isArray(arr, 2));
}
// #endregion is
// #endregion indices

// #region path
// #region all
bool isAllArray(Json json, string[][] paths) {
  return json.isObject && paths.length > 0
    ? paths.all!(path => json.isArray(path)) : false;
}
///
unittest {
  mixin(ShowTest!"Testing isAllArray for Json with paths");

  Json json = parseJsonString(`{"data": { "test1": [ [1, 2], {"a": 1} ], "test2": [3, 4] }}`);

  assert(json.isArray(["data", "test1"]));
  assert(json.isArray(["data", "test2"]));

  assert(json.isAllArray([["data", "test1"], ["data", "test2"]]));
  assert(!json.isAllArray([["data", "test1"], ["data", "nonexistent"]]));
}
// #endregion all

// #region any
bool isAnyArray(Json json, string[][] paths) {
  return json.isObject && paths.length > 0
    ? paths.any!(path => json.isArray(path)) : false;
}
///
unittest {
  mixin(ShowTest!"Testing isAllArray and isAnyArray for Json with paths");

  Json json = parseJsonString(`{"data": { "test1": [ [1, 2], {"a": 1} ], "test2": [3, 4] }}`);
  assert(isAnyArray(json, [["data", "test1"], ["data", "nonexistent"]]));
  assert(!isAnyArray(json, [["data", "nonexistent1"], ["data", "nonexistent2"]]));
}
// #endregion any

// #region is
bool isArray(Json json, string[] path) {
  return json.isObject && json.getValue(path).isArray;
}
///
unittest {
  mixin(ShowTest!"Testing isArray for Json with path");

  Json json = parseJsonString(`{"data": { "test": [ [1, 2], {"a": 1}, [3, 4] ]}}`);
  assert(isArray(json, ["data", "test"]));
  assert(!isArray(json, ["data", "nonexistent"]));
}
// #endregion is
// #endregion path

// #region key
// #region all
bool isAllArray(Json json, string[] keys) {
  return json.isObject && keys.length > 0
    ? keys.all!(key => json.isArray(key)) : false;
}
///
unittest {
  mixin(ShowTest!"Testing isAllArray for Json with keys");

  Json obj = [
    "a": [1, 2].toJson,
    "b": "not an array".toJson,
    "c": [3, 4].toJson
  ].toJson;
  assert(isAllArray(obj, ["a", "c"]));
  assert(!isAllArray(obj, ["a", "b"]));
}
// #endregion all

// #region any
bool isAnyArray(Json json, string[] keys) {
  return json.isObject && keys.length > 0
    ? keys.any!(key => json.isArray(key)) : false;
}
///
unittest {
  mixin(ShowTest!"Testing isArray for Json with keys");

  Json obj = [
    "a": [1, 2].toJson,
    "b": "not an array".toJson,
    "c": [3, 4].toJson
  ].toJson;
  assert(isAllArray(obj, ["a", "c"]));
  assert(!isAllArray(obj, ["a", "b"]));
  assert(isAnyArray(obj, ["b", "c"]));
  assert(!isAnyArray(obj, ["b", "d"]));
}
// #endregion any

// #region is
bool isArray(Json json, string key) {
  return json.isObject && json.getValue(key).isArray;
}
///
unittest {
  mixin(ShowTest!"Testing isArray for Json with key");

  Json obj = [
    "a": [1, 2].toJson,
    "b": "not an array".toJson,
    "c": [3, 4].toJson
  ].toJson;
  assert(isArray(obj, "a"));
  assert(!isArray(obj, "b"));
  assert(isArray(obj, "c"));
}
// #endregion is
// #endregion key
// #endregion Json

bool isArray(Json json) {
  return (json.type == Json.Type.array);
}
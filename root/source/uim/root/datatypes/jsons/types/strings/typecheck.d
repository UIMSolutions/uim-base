/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.types.strings.typecheck;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

// #region Json
// #region path
bool isAllString(Json json, string[][] paths) {
  return json.isObject ? json.toMap.isAllString(paths) : false;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isAllString for Json with paths");

  Json json = parseJsonString(`{"a": "ABC", "b": "XYZ", "c": 1}`);
  assert(json.isAllString([["a"], ["b"]]) == true);
  assert(json.isAnyString([["b"], ["c"]]) == true);
}

bool isAnyString(Json json, string[][] paths) {
  return json.isObject ? json.toMap.isAnyString(paths) : false;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isAnyString for Json with paths");

  Json json = parseJsonString(`{"a": "ABC", "b": "XYZ", "c": 1}`);
  assert(json.isAllString([["a"], ["b"]]) == true);
  assert(json.isAnyString([["b"], ["c"]]) == true);
}

bool isString(Json json, string[] path) {
  return json.isObject ? json.toMap.isString(path) : false;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isString for Json with path");

  Json json = parseJsonString(`{"a": "ABC", "b": "XYZ", "c": 1}`);
  assert(json.isString(["a"]) == true);
  assert(json.isString(["c"]) == false);
}

// #endregion path

// #region key
bool isAllString(Json json, string[] keys) {
  return json.isObject ? json.toMap.isAllString(keys) : false;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isAllString for Json with keys");

  Json json = parseJsonString(`{"a": "ABC", "b": "XYZ", "c": 1}`);
  assert(json.isAllString(["a", "b"]) == true);
  assert(json.isAnyString(["b", "c"]) == true);
}

bool isAnyString(Json json, string[] keys) {
  return json.isObject ? json.toMap.isAnyString(keys) : false;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isAnyString for Json with keys");

  Json json = parseJsonString(`{"a": "ABC", "b": "XYZ", "c": 1}`);
  assert(json.isAllString(["a", "b"]) == true);
  assert(json.isAnyString(["b", "c"]) == true);
}

bool isString(Json json, string key) {
  return json.isObject ? json.toMap.isString(key) : false;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isString for Json with key");

  Json json = parseJsonString(`{"a": "ABC", "b": "XYZ", "c": 1}`);
  assert(json.isString("a") == true);
  assert(json.isString("c") == false);
}
// #region key

// #region index
// #region is all
bool isAllString(Json json, size_t[] indices) {
  return json.isArray ? json.toArray.isAllString(indices) : false;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isAllString for Json with indices");

  Json json = ["ABC".toJson, "XYZ".toJson, 1.toJson].toJson;
  assert(json.isAllString([0, 1]) == true);
  assert(json.isAnyString([1, 2]) == true);
}
// #endregion is all

// #region is any
bool isAnyString(Json json, size_t[] indices) {
  return json.isArray ? json.toArray.isAnyString(indices) : false;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isAnyString for Json with indices");

  Json json = ["ABC".toJson, "XYZ".toJson, 1.toJson].toJson;
  assert(json.isAllString([0, 1]) == true);
  assert(json.isAnyString([1, 2]) == true);
}
// #endregion is any

// #region 
bool isString(Json json, size_t index) {
  return json.isArray ? json.toArray.isString(index) : false;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isString for Json with index");

  Json json = ["ABC".toJson, "XYZ".toJson, 1.toJson].toJson;
  assert(json.isString(0) == true);
  assert(json.isString(1) == true);
  assert(json.isString(2) == false);
}
// #endregion index

bool isString(Json json) {
  return (json.type == Json.Type.string);
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isString for Json");

  Json obj = parseJsonString(`{"a": "ABC", "b": 1, "c": 3.3}`);
  assert(isString("ABC".toJson) == true);
  assert(isString(1.toJson) == false);
  assert(isString(3.3.toJson) == false);
}
// #endregion Json

// #region Json[]
// #region indices
// #region is all string
bool isAllString(Json[] jsons, size_t[] indices = null) {
  return indices.length == 0
    ? jsons.length > 0 && jsons.all!(value => value.isString)
    : indices.all!(index => jsons.isString(index));
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isAllString for Json[] with indices");

  Json[] jsons = ["ABC".toJson, "XYZ".toJson, "123".toJson];
  assert(isAllString(jsons) == true);
  assert(isAnyString(jsons) == true);
  assert(isAllString(jsons, [0, 2]) == true);
  assert(isAnyString(jsons, [1, 2]) == true);
}
// #endregion is all string

// #region is any string
bool isAnyString(Json[] jsons, size_t[] indices = null) {
  return indices.length == 0
    ? jsons.length > 0 && jsons.any!(value => value.isString)
    : indices.any!(index => jsons.isString(index));
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isAnyString for Json[] with indices");

  Json[] jsons = ["ABC".toJson, 1.toJson, "XXX".toJson];
  assert(isAllString(jsons) == false);
  assert(isAnyString(jsons) == true);
  assert(isAllString(jsons, [0, 2]) == true);
  assert(isAnyString(jsons, [1, 2]) == true);
}
// #endregion is any string

// #region is string
bool isString(Json[] jsons, size_t index) {
  return jsons.length > index && jsons.getValue(index).isString;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isString for Json[] with index");

  Json[] jsons = ["ABC".toJson, 1.toJson, "XXX".toJson];
  assert(isString(jsons, 0) == true);
  assert(isString(jsons, 1) == false);
  assert(isString(jsons, 2) == true);
}
// #endregion is string
// #endregion indices
// #endregion Json[]

// #region Json[string]
// #region paths
// #region all string
bool isAllString(Json[string] jsons, string[][] paths = null) {
  return paths.length > 0 
    ? paths.all!(path => jsons.getValue(path).isString) 
    : jsons.byValue.all!(value => value.isString);
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isAllString for Json[string] with paths");

  Json[string] map = [
    "first": "ABC".toJson, "second": "XYZ".toJson, "third": "123".toJson
  ];
  assert(isAllString(map, [["first"], ["second"]]) == true);
  assert(isAnyString(map, [["second"], ["third"]]) == true);
}
// #endregion all string

// #region any string
bool isAnyString(Json[string] jsons, string[][] paths = null) {
  return paths.length > 0 
    ? paths.any!(path => jsons.getValue(path).isString) 
    : jsons.byValue.any!(value => value.isString);
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isAnyString for Json[string] with paths");

  Json[string] map = [
    "first": "ABC".toJson, "second": "XYZ".toJson, "third": 1.toJson
  ];
  assert(isAllString(map, [["first"], ["second"]]) == true);
  assert(isAnyString(map, [["second"], ["third"]]) == true);
}
// #endregion any string

// #region is string
bool isString(Json[string] jsons, string[] path) {
  return jsons.getValue(path).isString;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isString for Json[string] with path");

  Json[string] map = [
    "first": "ABC".toJson, "second": "XYZ".toJson, "third": 1.toJson
  ];
  assert(isString(map, ["first"]) == true);
  assert(isString(map, ["third"]) == false);
}
// #endregion is string
// #endregion paths

// #region keys
// #region is all string
bool isAllString(Json[string] jsons, string[] keys = null) {
  return keys.length > 0 
    ? keys.all!(key => jsons.getValue(key).isString) 
    : jsons.byValue.all!(value => value.isString);
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isAllString for Json[string] with keys");

  Json[string] map = [
    "first": "ABC".toJson, "second": "XYZ".toJson, "third": 1.toJson
  ];
  assert(isAllString(map, ["first", "second"]) == true);
  assert(isAnyString(map, ["second", "third"]) == true);
}
// #endregion is all string

// #region is any string
bool isAnyString(Json[string] jsons, string[] keys = null) {
  return keys.length > 0 
    ? keys.any!(key => jsons.getValue(key).isString) 
    : jsons.byValue.any!(value => value.isString);
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isAnyString for Json[string] with keys");

  Json[string] map = [
    "first": "ABC".toJson, "second": "XYZ".toJson, "third": 1.toJson
  ];
  assert(isAllString(map, ["first", "second"]) == true);
  assert(isAnyString(map, ["second", "third"]) == true);
}
// #endregion is any string

// #region is string
bool isString(Json[string] jsons, string key) {
  return jsons.getValue(key).isString;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isString for Json[string] with key");

  Json[string] map = [
    "first": "ABC".toJson, "second": "XYZ".toJson, "third": 1.toJson
  ];
  assert(isString(map, "first") == true);
  assert(isString(map, "third") == false);
}
// #endregion is string
// #endregion keys
// #endregion Json[string]
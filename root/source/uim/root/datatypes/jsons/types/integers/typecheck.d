/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.types.integers.typecheck;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

// #region Json
// #region path
bool isAllInteger(Json json, string[][] paths) {
  return json.isObject ? json.toMap.isAllInteger(paths) : false;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isAllInteger for Json with paths");

  Json json = parseJsonString(`{"a": 1, "b": 2, "c": "not a integer"}`);
  assert(json.isAllInteger([["a"], ["b"]]) == true);
  assert(json.isAnyInteger([["b"], ["c"]]) == true);
}

bool isAnyInteger(Json json, string[][] paths) {
  return json.isObject ? json.toMap.isAnyInteger(paths) : false;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isAnyInteger for Json with paths");

  Json json = parseJsonString(`{"a": 1, "b": 2, "c": "not a integer"}`);
  assert(json.isAllInteger([["a"], ["b"]]) == true);
  assert(json.isAnyInteger([["b"], ["c"]]) == true);
}

bool isInteger(Json json, string[] path) {
  return json.isObject ? json.toMap.isInteger(path) : false;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isInteger for Json with path");

  Json json = parseJsonString(`{"a": 1, "b": 2, "c": "not a integer"}`);
  assert(json.isInteger(["a"]) == true);
  assert(json.isInteger(["c"]) == false);
}

// #endregion path

// #region key
bool isAllInteger(Json json, string[] keys) {
  return json.isObject ? json.toMap.isAllInteger(keys) : false;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isAllInteger for Json with keys");

  Json json = parseJsonString(`{"a": 1, "b": 2, "c": "not a integer"}`);
  assert(json.isAllInteger(["a", "b"]) == true);
  assert(json.isAnyInteger(["b", "c"]) == true);
}

bool isAnyInteger(Json json, string[] keys) {
  return json.isObject ? json.toMap.isAnyInteger(keys) : false;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isAnyInteger for Json with keys");

  Json json = parseJsonString(`{"a": 1, "b": 2, "c": "not a integer"}`);
  assert(json.isAllInteger(["a", "b"]) == true);
  assert(json.isAnyInteger(["b", "c"]) == true);
}

bool isInteger(Json json, string key) {
  return json.isObject ? json.toMap.isInteger(key) : false;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isInteger for Json with key");

  Json json = parseJsonString(`{"a": 1, "b": 2, "c": "not a integer"}`);
  assert(json.isInteger("a") == true);
  assert(json.isInteger("c") == false);
}
// #region key

// #region index
bool isAllInteger(Json json, size_t[] indices) {
  return json.isArray ? json.toArray.isAllInteger(indices) : false;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isAllInteger for Json with indices");

  Json json = [1.toJson, 2.toJson, "not a integer".toJson].toJson;
  assert(json.isAllInteger([0, 1]) == true);
  assert(json.isAnyInteger([1, 2]) == true);
}

bool isAnyInteger(Json json, size_t[] indices) {
  return json.isArray ? json.toArray.isAnyInteger(indices) : false;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isAnyInteger for Json with indices");

  Json json = [1.toJson, 2.toJson, "not a integer".toJson].toJson;
  assert(json.isAllInteger([0, 1]) == true);
  assert(json.isAnyInteger([1, 2]) == true);
}

bool isInteger(Json json, size_t index) {
  return json.isArray ? json.toArray.isInteger(index) : false;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isInteger for Json with index");

  Json json = [1.toJson, 2.toJson, "not a integer".toJson].toJson;
  assert(json.isInteger(0) == true);
  assert(json.isInteger(1) == true);
  assert(json.isInteger(2) == false);
}
// #endregion index

bool isInteger(Json json) {
  return (json.type == Json.Type.int_);
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isInteger for Json");

  Json obj = parseJsonString(`{"a": 1, "b": "not a integer", "c": 3}`);
  assert(isInteger(1.toJson) == true);
  assert(isInteger("not a integer".toJson) == false);
  assert(isInteger(3.toJson) == true);
}
// #endregion Json

// #region Json[]
// #region indices
// #region is all integer
bool isAllInteger(Json[] jsons, size_t[] indices = null) {
  return indices.length == 0
    ? jsons.length > 0 && jsons.all!(value => value.isInteger)
    : indices.all!(index => jsons.isInteger(index));
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isAllInteger for Json[] with indices");

  Json[] jsons = [1.toJson, 2.toJson, 3.toJson];
  assert(isAllInteger(jsons) == true);
  assert(isAnyInteger(jsons) == true);
  assert(isAllInteger(jsons, [0, 2]) == true);
  assert(isAnyInteger(jsons, [1, 2]) == true);
}
// #endregion is all integer

// #region is any integer
bool isAnyInteger(Json[] jsons, size_t[] indices = null) {
  return indices.length == 0
    ? jsons.length > 0 && jsons.any!(value => value.isInteger)
    : indices.any!(index => jsons.isInteger(index));
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isAnyInteger for Json[] with indices");

  Json[] jsons = [1.toJson, "not a integer".toJson, 3.toJson];
  assert(isAllInteger(jsons) == false);
  assert(isAnyInteger(jsons) == true);
  assert(isAllInteger(jsons, [0, 2]) == true);
  assert(isAnyInteger(jsons, [1, 2]) == true);
}
// #endregion is any integer

// #region is integer
bool isInteger(Json[] jsons, size_t index) {
  return jsons.length > index && jsons.getValue(index).isInteger;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isInteger for Json[] with index");

  Json[] jsons = [1.toJson, "not a integer".toJson, 3.toJson];
  assert(isInteger(jsons, 0) == true);
  assert(isInteger(jsons, 1) == false);
  assert(isInteger(jsons, 2) == true);
}
// #endregion is integer
// #endregion indices
// #endregion Json[]

// #region Json[string]
// #region paths
// #region all integer
bool isAllInteger(Json[string] jsons, string[][] paths = null) {
  return paths.length > 0 
    ? paths.all!(path => jsons.getValue(path).isInteger) 
    : jsons.byValue.all!(value => value.isInteger);
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isAllInteger for Json[string] with paths");

  Json[string] map = [
    "first": 1.toJson, "second": 2.toJson, "third": "not a integer".toJson
  ];
  assert(isAllInteger(map, [["first"], ["second"]]) == true);
  assert(isAnyInteger(map, [["second"], ["third"]]) == true);
}
// #endregion all integer

// #region any integer
bool isAnyInteger(Json[string] jsons, string[][] paths = null) {
  return paths.length > 0 
    ? paths.any!(path => jsons.getValue(path).isInteger) 
    : jsons.byValue.any!(value => value.isInteger);
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isAnyInteger for Json[string] with paths");

  Json[string] map = [
    "first": 1.toJson, "second": 2.toJson, "third": "not a integer".toJson
  ];
  assert(isAllInteger(map, [["first"], ["second"]]) == true);
  assert(isAnyInteger(map, [["second"], ["third"]]) == true);
}
// #endregion any integer

// #region is integer
bool isInteger(Json[string] jsons, string[] path) {
  return jsons.getValue(path).isInteger;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isInteger for Json[string] with path");

  Json[string] map = [
    "first": 1.toJson, "second": 2.toJson, "third": "not a integer".toJson
  ];
  assert(isInteger(map, ["first"]) == true);
  assert(isInteger(map, ["third"]) == false);
}
// #endregion is integer
// #endregion paths

// #region keys
// #region is all integer
bool isAllInteger(Json[string] jsons, string[] keys = null) {
  return keys.length > 0 
    ? keys.all!(key => jsons.getValue(key).isInteger) 
    : jsons.byValue.all!(value => value.isInteger);
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isAllInteger for Json[string] with keys");

  Json[string] map = [
    "first": 1.toJson, "second": 2.toJson, "third": "not a integer".toJson
  ];
  assert(isAllInteger(map, ["first", "second"]) == true);
  assert(isAnyInteger(map, ["second", "third"]) == true);
}
// #endregion is all integer

// #region is any integer
bool isAnyInteger(Json[string] jsons, string[] keys = null) {
  return keys.length > 0 
    ? keys.any!(key => jsons.getValue(key).isInteger) 
    : jsons.byValue.any!(value => value.isInteger);
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isAnyInteger for Json[string] with keys");

  Json[string] map = [
    "first": 1.toJson, "second": 2.toJson, "third": "not a integer".toJson
  ];
  assert(isAllInteger(map, ["first", "second"]) == true);
  assert(isAnyInteger(map, ["second", "third"]) == true);
}
// #endregion is any integer

// #region is integer
bool isInteger(Json[string] jsons, string key) {
  return jsons.getValue(key).isInteger;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isInteger for Json[string] with key");

  Json[string] map = [
    "first": 1.toJson, "second": 2.toJson, "third": "not a integer".toJson
  ];
  assert(isInteger(map, "first") == true);
  assert(isInteger(map, "third") == false);
}
// #endregion is integer
// #endregion keys
// #endregion Json[string]
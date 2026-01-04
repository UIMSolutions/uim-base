/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.types.doubles.typecheck;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

// #region Json
// #region path
bool isAllDouble(Json json, string[][] paths) {
  return json.isObject ? json.toMap.isAllDouble(paths) : false;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isAllDouble for Json with paths");

  Json json = parseJsonString(`{"a": 1.1, "b": 2.2, "c": "not a double"}`);
  assert(isAllDouble(json, [["a"], ["b"]]) == true);
  assert(isAnyDouble(json, [["b"], ["c"]]) == true);
}

bool isAnyDouble(Json json, string[][] paths) {
  return json.isObject ? json.toMap.isAnyDouble(paths) : false;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isAnyDouble for Json with paths");

  Json json = parseJsonString(`{"a": 1.1, "b": 2.2, "c": "not a double"}`);
  assert(isAllDouble(json, [["a"], ["b"]]) == true);
  assert(isAnyDouble(json, [["b"], ["c"]]) == true);
}

bool isDouble(Json json, string[] path) {
  return json.isObject ? json.toMap.isDouble(path) : false;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isDouble for Json with path");

  Json json = parseJsonString(`{"a": 1.1, "b": 2.2, "c": "not a double"}`);
  assert(isDouble(json, ["a"]) == true);
  assert(isDouble(json, ["c"]) == false);
}

// #endregion path

// #region key
bool isAllDouble(Json json, string[] keys) {
  return json.isObject ? json.toMap.isAllDouble(keys) : false;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isAllDouble for Json with keys");

  Json json = parseJsonString(`{"a": 1.1, "b": 2.2, "c": "not a double"}`);
  assert(isAllDouble(json, ["a", "b"]) == true);
  assert(isAnyDouble(json, ["b", "c"]) == true);
}

bool isAnyDouble(Json json, string[] keys) {
  return json.isObject ? json.toMap.isAnyDouble(keys) : false;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isAnyDouble for Json with keys");

  Json json = parseJsonString(`{"a": 1.1, "b": 2.2, "c": "not a double"}`);
  assert(isAllDouble(json, ["a", "b"]) == true);
  assert(isAnyDouble(json, ["b", "c"]) == true);
}

bool isDouble(Json json, string key) {
  return json.isObject ? json.toMap.isDouble(key) : false;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isDouble for Json with key");

  Json json = parseJsonString(`{"a": 1.1, "b": 2.2, "c": "not a double"}`);
  assert(isDouble(json, "a") == true);
  assert(isDouble(json, "c") == false);
}
// #region key

// #region index
bool isAllDouble(Json json, size_t[] indices) {
  return json.isArray ? json.toArray.isAllDouble(indices) : false;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isAllDouble for Json with indices");

  Json json = [1.1.toJson, 2.2.toJson, "not a double".toJson].toJson;
  assert(isAllDouble(json, [0, 1]) == true);
  assert(isAnyDouble(json, [1, 2]) == true);
}

bool isAnyDouble(Json json, size_t[] indices) {
  return json.isArray ? json.toArray.isAnyDouble(indices) : false;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isAnyDouble for Json with indices");

  Json json = [1.1.toJson, 2.2.toJson, "not a double".toJson].toJson;
  assert(isAllDouble(json, [0, 1]) == true);
  assert(isAnyDouble(json, [1, 2]) == true);
}

bool isDouble(Json json, size_t index) {
  return json.isArray ? json.toArray.isDouble(index) : false;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isDouble for Json with index");

  Json json = [1.1.toJson, 2.2.toJson, "not a double".toJson].toJson;
  assert(isDouble(json, 0) == true);
  assert(isDouble(json, 1) == true);
  assert(isDouble(json, 2) == false);
}
// #endregion index

bool isDouble(Json json) {
  return (json.type == Json.Type.float_);
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isDouble for Json");

  Json obj = parseJsonString(`{"a": 1.1, "b": "not a double", "c": 3.3}`);
  assert(isDouble(1.1.toJson) == true);
  assert(isDouble("not a double".toJson) == false);
  assert(isDouble(3.3.toJson) == true);
}
// #endregion Json

// #region Json[]
// #region indices
// #region is all double
bool isAllDouble(Json[] jsons, size_t[] indices = null) {
  return indices.length == 0
    ? jsons.length > 0 && jsons.all!(value => value.isDouble)
    : indices.all!(index => jsons.isDouble(index));
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isAllDouble for Json[] with indices");

  Json[] jsons = [1.1.toJson, 2.2.toJson, 3.3.toJson];
  assert(isAllDouble(jsons) == true);
  assert(isAnyDouble(jsons) == true);
  assert(isAllDouble(jsons, [0, 2]) == true);
  assert(isAnyDouble(jsons, [1, 2]) == true);
}
// #endregion is all double

// #region is any double
bool isAnyDouble(Json[] jsons, size_t[] indices = null) {
  return indices.length == 0
    ? jsons.length > 0 && jsons.any!(value => value.isDouble)
    : indices.any!(index => jsons.isDouble(index));
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isAnyDouble for Json[] with indices");

  Json[] jsons = [1.1.toJson, "not a double".toJson, 3.3.toJson];
  assert(isAllDouble(jsons) == false);
  assert(isAnyDouble(jsons) == true);
  assert(isAllDouble(jsons, [0, 2]) == true);
  assert(isAnyDouble(jsons, [1, 2]) == true);
}
// #endregion is any double

// #region is double
bool isDouble(Json[] jsons, size_t index) {
  return jsons.length > index && jsons.getValue(index).isDouble;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isDouble for Json[] with index");

  Json[] jsons = [1.1.toJson, "not a double".toJson, 3.3.toJson];
  assert(isDouble(jsons, 0) == true);
  assert(isDouble(jsons, 1) == false);
  assert(isDouble(jsons, 2) == true);
}
// #endregion is double
// #endregion indices
// #endregion Json[]

// #region Json[string]
// #region paths
// #region all double
bool isAllDouble(Json[string] jsons, string[][] paths = null) {
  return paths.length > 0 
    ? paths.all!(path => jsons.getValue(path).isDouble) 
    : jsons.byValue.all!(value => value.isDouble);
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isAllDouble for Json[string] with paths");

  Json[string] map = [
    "first": 1.1.toJson, "second": 2.2.toJson, "third": "not a double".toJson
  ];
  assert(isAllDouble(map, [["first"], ["second"]]) == true);
  assert(isAnyDouble(map, [["second"], ["third"]]) == true);
}
// #endregion all double

// #region any double
bool isAnyDouble(Json[string] jsons, string[][] paths = null) {
  return paths.length > 0 
    ? paths.any!(path => jsons.getValue(path).isDouble) 
    : jsons.byValue.any!(value => value.isDouble);
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isAnyDouble for Json[string] with paths");

  Json[string] map = [
    "first": 1.1.toJson, "second": 2.2.toJson, "third": "not a double".toJson
  ];
  assert(isAllDouble(map, [["first"], ["second"]]) == true);
  assert(isAnyDouble(map, [["second"], ["third"]]) == true);
}
// #endregion any double

// #region is double
bool isDouble(Json[string] jsons, string[] path) {
  return jsons.getValue(path).isDouble;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isDouble for Json[string] with path");

  Json[string] map = [
    "first": 1.1.toJson, "second": 2.2.toJson, "third": "not a double".toJson
  ];
  assert(isDouble(map, ["first"]) == true);
  assert(isDouble(map, ["third"]) == false);
}
// #endregion is double
// #endregion paths

// #region keys
// #region is all double
bool isAllDouble(Json[string] jsons, string[] keys = null) {
  return keys.length > 0 
    ? keys.all!(key => jsons.getValue(key).isDouble) 
    : jsons.byValue.all!(value => value.isDouble);
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isAllDouble for Json[string] with keys");

  Json[string] map = [
    "first": 1.1.toJson, "second": 2.2.toJson, "third": "not a double".toJson
  ];
  assert(isAllDouble(map, ["first", "second"]) == true);
  assert(isAnyDouble(map, ["second", "third"]) == true);
}
// #endregion is all double

// #region is any double
bool isAnyDouble(Json[string] jsons, string[] keys = null) {
  return keys.length > 0 
    ? keys.any!(key => jsons.getValue(key).isDouble) 
    : jsons.byValue.any!(value => value.isDouble);
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isAnyDouble for Json[string] with keys");

  Json[string] map = [
    "first": 1.1.toJson, "second": 2.2.toJson, "third": "not a double".toJson
  ];
  assert(isAllDouble(map, ["first", "second"]) == true);
  assert(isAnyDouble(map, ["second", "third"]) == true);
}
// #endregion is any double

// #region is double
bool isDouble(Json[string] jsons, string key) {
  return jsons.getValue(key).isDouble;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isDouble for Json[string] with key");

  Json[string] map = [
    "first": 1.1.toJson, "second": 2.2.toJson, "third": "not a double".toJson
  ];
  assert(isDouble(map, "first") == true);
  assert(isDouble(map, "third") == false);
}
// #endregion is double
// #endregion keys
// #endregion Json[string]
/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.types.strings.typecheck;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

// #region Json[]
bool isAllString(Json[] jsons, size_t[] indices = null) {
  return indices.length == 0
    ? jsons.length > 0 && jsons.all!(value => value.isString)
    : indices.all!(index => jsons.isString(index));
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing isAllString for Json[] with indices");

  Json[] jsons = [Json("hello"), 123.toJson, Json("world")];
  assert(isAllString(jsons) == false);
  assert(isAnyString(jsons) == true);
  assert(isAllString(jsons, [0, 2]) == true);
  assert(isAnyString(jsons, [1, 2]) == true);
}

bool isAnyString(Json[] jsons, size_t[] indices = null) {
  return indices.length == 0
    ? jsons.length > 0 && jsons.any!(value => value.isString)
    : indices.any!(index => jsons.isString(index));
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing isAllString and isAnyString for Json[] with indices");

  Json[] jsons = [Json("hello"), 123.toJson, Json("world")];
  assert(isAllString(jsons) == false);
  assert(isAnyString(jsons) == true);
  assert(isAllString(jsons, [0, 2]) == true);
  assert(isAnyString(jsons, [1, 2]) == true);
}

bool isString(Json[] jsons, size_t index) {
  return jsons.length > index && jsons.getValue(index).isString;
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing isString for Json[]");
    
  Json[] jsons = [Json("hello"), 123.toJson, Json("world")];
  assert(isAllString(jsons) == false);
  assert(isAnyString(jsons) == true);
  assert(isAllString(jsons, [0, 2]) == true);
  assert(isString(jsons, 0) == true);
  assert(isString(jsons, 1) == false);
  assert(isString(jsons, 2) == true);
}
// #endregion Json[]

// #region Json[string]
bool isAllString(Json[string] map, string[] keys = null) {
  return keys.length > 0 
    ? keys.all!(key => map.getValue(key).isString) 
    : map.byValue.all!(value => value.isString);
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing isAllString for Json[string] with keys");

  Json[string] map = [
    "first": Json("hello"), "second": 123.toJson, "third": Json("world")
  ];
  assert(isAllString(map) == false);
  assert(isAnyString(map) == true);
  assert(isAllString(map, ["first", "third"]) == true);
  assert(isAnyString(map, ["second", "third"]) == true);
}

bool isAnyString(Json[string] map, string[] keys = null) {
  return keys.length > 0 
    ? keys.any!(key => map.getValue(key).isString) 
    : map.byValue.any!(value => value.isString);
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing isAllString and isAnyString for Json[string] with keys");

  Json[string] map = [
    "first": Json("hello"), "second": 123.toJson, "third": Json("world")
  ];
  assert(isAllString(map) == false);
  assert(isAnyString(map) == true);
  assert(isAllString(map, ["first", "third"]) == true);
  assert(isAnyString(map, ["second", "third"]) == true);
}

bool isString(Json[string] map, string key) {
  return key in map ? map[key].isString : false;
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing isString for Json[string]");
    
  Json[string] map = [
    "first": Json("hello"), "second": 123.toJson, "third": Json("world")
  ];
  assert(isAllString(map) == false);
  assert(isAnyString(map) == true);
  assert(isAllString(map, ["first", "third"]) == true);
  assert(isString(map, "first") == true);
  assert(isString(map, "second") == false);
  assert(isString(map, "third") == true);
}
    // #endregion Json[string]

// #region Json
// #region path
bool isAllString(Json json, string[][] paths) {
  return json.isObject && paths.length > 0
    ? paths.all!(path => json.isString(path)) : false;
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing isAllString for Json with paths");

  Json json = parseJsonString(`{
    "first": "hello",
    "second": 123,
    "third": "world",
    "nested": {
      "a": "foo",
      "b": 456
    }
  }`);

  assert(isAllString(json, [["first"], ["third"]]) == true);
  assert(isAllString(json, [["first"], ["second"]]) == false);
  assert(isAllString(json, [["nested", "a"], ["third"]]) == true);
  assert(isAllString(json, [["nested", "b"], ["third"]]) == false);
}

bool isAnyString(Json json, string[][] paths) {
  return json.isObject && paths.length > 0
    ? paths.any!(path => json.isString(path)) : false;
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing isAnyString for Json with paths");

  Json json = parseJsonString(`{
    "first": "hello",
    "second": 123,
    "third": "world",
    "nested": {
      "a": "foo",
      "b": 456
    }
  }`);

  assert(isAnyString(json, [["first"], ["second"]]) == true);
  assert(isAnyString(json, [["second"], ["b"]]) == false);
  assert(isAnyString(json, [["nested", "a"], ["second"]]) == true);
  assert(isAnyString(json, [["nested", "b"], ["second"]]) == false);
}

bool isString(Json json, string[] path) {
  return json.isObject && path.length > 0 ? json.getValue(path).isString : false;
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing isString for Json with path");

  Json json = parseJsonString(`{
    "first": "hello",
    "second": 123,
    "third": "world",
    "nested": {
      "a": "foo",
      "b": 456
    }
  }`);

  assert(isString(json, ["first"]) == true);
  assert(isString(json, ["second"]) == false);
  assert(isString(json, ["third"]) == true);
  assert(isString(json, ["nested", "a"]) == true);
  assert(isString(json, ["nested", "b"]) == false);
}
  // #endregion path

// #region key
bool isAllString(Json json, string[] keys) {
  return json.isObject && keys.length > 0
    ? keys.all!(key => json.isString(key)) : false;
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing isAllString for Json with keys");

  Json json = parseJsonString(`{
    "first": "hello",
    "second": 123,
    "third": "world"
  }`);

  assert(isAllString(json, ["first", "third"]) == true);
  assert(isAllString(json, ["first", "second"]) == false);
}

bool isAnyString(Json json, string[] keys) {
  return json.isObject && keys.length > 0
    ? keys.any!(key => json.isString(key)) : false;
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing isAnyString for Json with keys");

  Json json = parseJsonString(`{
    "first": "hello",
    "second": 123,
    "third": "world"
  }`);

  assert(isAnyString(json, ["second", "third"]) == true);
  assert(isAnyString(json, ["second", "fourth"]) == false);
}

bool isString(Json json, string key) {
  return json.isObject ? json.getValue(key).isString : false;
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing isString for Json with key");

  Json json = parseJsonString(`{
    "first": "hello",
    "second": 123,
    "third": "world"
  }`);

  assert(isString(json, "first") == true);
  assert(isString(json, "second") == false);
  assert(isString(json, "third") == true);
}
// #region key

// #region index
bool isAllString(Json json, size_t[] indices) {
  return json.isArray && indices.length > 0
    ? indices.all!(index => json.isString(index)) : false;
}

bool isAnyString(Json json, size_t[] indices) {
  return json.isArray && indices.length > 0
    ? indices.any!(index => json.isString(index)) : false;
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing isAllString and isAnyString for Json with indices");

  Json json = [Json("hello"), 123.toJson, Json("world")].toJson;

  assert(isAllString(json, [0, 2]) == true);
  assert(isAllString(json, [0, 1]) == false);
  assert(isAnyString(json, [1, 2]) == true);
  assert(isAnyString(json, [1, 3]) == false);
}

bool isString(Json json, size_t index) {
  return json.isArray && index < json.length ? json.getValue(index).isString : false;
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing isString for Json with index");  


  Json json = [Json("hello"), 123.toJson, Json("world")].toJson;  
  assert(isString(json, 0) == true);
  assert(isString(json, 1) == false);
  assert(isString(json, 2) == true);
}
  // #endregion index

bool isString(Json json) {
  return (json.type == Json.Type.string);
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing isString for Json");

  Json strJson = Json("hello");
  Json intJson = 123.toJson;

  assert(isString(strJson) == true);
  assert(isString(intJson) == false);
}
// #endregion Json
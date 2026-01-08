/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.types.objects.typecheck;

import uim.root;

mixin(Version!("show_module"));

@safe:

// #region Json[]
/** 
  * Checks whether all Json values at the specified indices in the array are objects.
  * 
  * Params:
  *   jsons = The array of Json values to check.
  *   indices = The indices of the Json values to check.
  * 
  * Returns:
  *   true if all specified Json values are objects, false otherwise.
  */
bool isAllObject(Json[] jsons, size_t[] indices = null) {
  return indices.length == 0
    ? jsons.length > 0 && jsons.all!(value => value.isObject)
    : indices.all!(index => jsons.isObject(index));
}
///
unittest {
  auto arr = [
    ["key": "value"].toJson, ["anotherKey": 123].toJson, [1, 2, 3].toJson
  ];
  assert(isAllObject(arr, [0, 1]));
  assert(!isAllObject(arr, [0, 2]));
}

/** 
  * Checks whether any Json value at the specified indices in the array is an object.
  * 
  * Params:
  *   values = The array of Json values to check.
  *   indices = The indices of the Json values to check.
  * 
  * Returns:
  *   true if any specified Json value is an object, false otherwise.
  */
bool isAnyObject(Json[] jsons, size_t[] indices = null) {
  return indices.length == 0
    ? jsons.length > 0 && jsons.any!(value => value.isObject)
    : indices.any!(index => jsons.isObject(index));
}
///
unittest {
  auto arr = [
    ["key": "value"].toJson, [1, 2, 3].toJson, [true, false].toJson
  ];
  assert(isAnyObject(arr, [0, 2]));
  assert(!isAnyObject(arr, [1, 2]));
}

/**
  * Checks whether the Json value at the specified index in the array is an object.
  * 
  * Params:
  *   values = The array of Json values to check.
  *   index = The index of the Json value to check.
  * 
  * Returns:
  *   true if the specified Json value is an object, false otherwise.
  */
bool isObject(Json[] jsons, size_t index) {
  return jsons.length > index && jsons.getValue(index).isObject;
}
///
unittest {
  auto arr = [
    ["key": "value"].toJson, [1, 2, 3].toJson
  ];
  assert(isObject(arr, 0));
  assert(!isObject(arr, 1));
}
// #endregion Json[]

// #region Json[string]
/**
  * Checks whether all Json values at the specified keys in the associative array are objects.
  * 
  * Params:
  *   values = The associative array of Json values to check.
  *   keys = The keys of the Json values to check.
  * 
  * Returns:
  *   true if all specified Json values are objects, false otherwise.
  */
bool isAllObject(Json[string] jsons, string[] keys = null) {
  return keys.length == 0
    ? jsons.length > 0 && jsons.byValue.all!(value => isObject(value))
    : keys.all!(key => jsons.isObject(key));
}
///
unittest {
  Json[string] map = [
    "first": ["key": "value"].toJson,
    "second": ["anotherKey": 123].toJson,
    "third": [1, 2, 3].toJson
  ];
  assert(map.isAllObject(["first", "second"]));
  assert(!map.isAllObject(["first", "third"]));
}

bool isAnyObject(Json[string] jsons, string[] keys = null) {
  return keys.length == 0
    ? jsons.length > 0 && jsons.byValue.any!(
      value => value.isObject) : keys.any!(key => jsons.isObject(key));
}
///
unittest {
  Json[string] map = [
    "first": ["key": "value"].toJson,
    "second": [1, 2, 3].toJson,
    "third": [true, false].toJson
  ];
  assert(map.isAnyObject(["first", "second"]));
  assert(!map.isAnyObject(["second", "third"]));
}

/** 
  * Checks whether the Json value at the specified key in the associative array is an object.
  * 
  * Params:
  *   values = The associative array of Json values to check.
  *   key = The key of the Json value to check.
  * 
  * Returns:
  *   true if the specified Json value is an object, false otherwise.
  */
bool isObject(Json[string] jsons, string key) {
  return jsons.getValue(key).isObject;
}
// #endregion Json[string]

// #region Json
// #region path
bool isAllObject(Json json, string[][] paths) {
  return json.isObject && paths.length > 0
    ? paths.all!(path => json.isObject(path)) : false;
}

bool isAnyObject(Json json, string[][] paths) {
  return json.isObject && paths.length > 0
    ? paths.any!(path => json.isObject(path)) : false;
}

bool isObject(Json json, string[] path) {
  return json.getValue(path).isObject;
}
// #endregion path

// #region key
bool isAllObject(Json json, string[] keys) {
  return json.isObject && keys.length > 0
    ? keys.all!(key => json.isObject(key)) : false;
}

bool isAnyObject(Json json, string[] keys) {
  return json.isObject && keys.length > 0
    ? keys.any!(key => json.isObject(key)) : false;
}

bool isObject(Json json, string key) {
  return json.getValue(key).isObject;
}
// #region key

// #region index
bool isAllObject(Json json, size_t[] indices) {
  return json.isObject && indices.length > 0
    ? indices.all!(index => json.isObject(index)) : false;
}

bool isAnyObject(Json json, size_t[] indices) {
  return json.isObject && indices.length > 0
    ? indices.any!(index => json.isObject(index)) : false;
}

bool isObject(Json json, size_t index) {
  return json.getValue(index).isObject;
}
// #endregion index


// #endregion Json
bool isObject(Json json) {
  return (json.type == Json.Type.object);
}


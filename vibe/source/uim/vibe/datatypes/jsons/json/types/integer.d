/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.json.types.integer;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region path
// #region all
// #region noValue
/** 
  * Checks if the given JSON value at the specified path is of integer type.
  *
  * Params:
  *   json = The JSON value to check.
  *   paths = The paths within the JSON object to check.
  *
  * Returns:
  *   `true` if the JSON value at the specified path is an integer, `false` otherwise.
  */
bool isAllInteger(Json json, string[][] paths) {
  return paths.all!(path => json.isInteger(path));
}
///
unittest {
  // Test isAllInteger with string[][] paths - empty paths
  Json json1 = Json.emptyObject;
  string[][] emptyPaths = [];
  assert(!json1.isAllInteger(emptyPaths));

  // Test isAllInteger with string[][] paths - single valid integer path
  Json json2 = Json.emptyObject;
  json2["a"] = Json(42);
  string[][] paths = [["a"]];
  assert(json2.isAllInteger(paths));

  // Test isAllInteger with string[][] paths - multiple valid integer paths
  Json json3 = Json.emptyObject;
  json3["a"] = Json(10);
  json3["b"] = Json(20);
  string[][] paths = [["a"], ["b"]];
  assert(json3.isAllInteger(paths));

  // Test isAllInteger with string[][] paths - mixed types (should return true if any is integer)
  Json json4 = Json.emptyObject;
  json4["a"] = Json(10);
  json4["b"] = Json("text");
  string[][] paths = [["a"], ["b"]];
  assert(json4.isAllInteger(paths));

  // Test isAllInteger with string[][] paths - no integers
  Json json5 = Json.emptyObject;
  json5["a"] = Json("text");
  json5["b"] = Json(3.14);
  string[][] paths = [["a"], ["b"]];
  assert(!json5.isAllInteger(paths));

  // Test isAllInteger with string[][] paths - nested paths
  Json json6 = Json.emptyObject;
  json6["outer"] = Json.emptyObject;
  json6["outer"]["inner"] = Json(100);
  string[][] paths = [["outer", "inner"]];
  assert(json6.isAllInteger(paths));

  // Test isAllInteger with string[][] paths - non-existent paths
  Json json7 = Json.emptyObject;
  json7["a"] = Json(10);
  string[][] paths = [["nonexistent"]];
  assert(!json7.isAllInteger(paths));

  // Test isAllInteger with string[][] paths and value - matching value
  Json json8 = Json.emptyObject;
  json8["a"] = Json(42);
  json8["b"] = Json(42);
  string[][] paths = [["a"], ["b"]];
  assert(json8.isAllInteger(paths, 42));

  // Test isAllInteger with string[][] paths and value - non-matching value
  Json json9 = Json.emptyObject;
  json9["a"] = Json(10);
  json9["b"] = Json(20);
  string[][] paths = [["a"], ["b"]];
  assert(!json9.isAllInteger(paths, 42));

  // Test isAllInteger with string[][] paths and value - partial match
  Json json10 = Json.emptyObject;
  json10["a"] = Json(42);
  json10["b"] = Json(10);
  string[][] paths = [["a"], ["b"]];
  assert(!json10.isAllInteger(paths, 42));
}
// #endregion noValue

// #region value
/** 
  * Checks if the given JSON value at the specified path is of integer type and matches the given value.
  *
  * Params:
  *   json = The JSON value to check.
  *   paths = The paths within the JSON object to check.
  *   value = The integer value to match.
  *
  * Returns:
  *   `true` if the JSON value at the specified path is an integer and matches the given value, `false` otherwise.
  */
bool isAllInteger(Json json, string[][] paths, int value) {
  return paths.all!(path => json.isInteger(path, value));
}
// #endregion value
// #endregion all

// #region any
// #region noValue
bool isAnyInteger(Json json, string[][] paths) {
  return paths.any!(path => json.isInteger(path));
}
// #endregion noValue

// #region value
bool isAnyInteger(Json json, string[][] paths, int value) {
  return paths.any!(path => json.isInteger(path, value));
}
// #endregion value
// #endregion any

// #region is
// #region noValue
bool isInteger(Json json, string[] path) {
  if (!json.hasPath(path)) {
    return false;
  }

  if (path.length == 1) {
    return json.isInteger(path[0]);
  }

  return json[path[0]].isInteger(path[1 .. $]);
}
// #endregion noValue

// #region value
bool isInteger(Json json, string[] path, int value) {
  return json.isInteger(path) && json.getInteger(path) == value;
}
// #endregion value
// #endregion is
// #endregion path

// #region key
// #region all
bool isAllInteger(Json json, string[] keys) {
  return keys.any!(key => json.isInteger(key));
}

bool isAllInteger(Json json, string[] keys, int value) {
  return keys.any!(key => json.isInteger(key) && json.getInteger(key) == value);
}
// #endregion all

// #region any
// #region value
bool isAnyInteger(Json json, string[] keys, int value) {
  return keys.any!(key => json.isInteger(key, value));
}
// #endregion value

// #region noValue
bool isAnyInteger(Json json, string[] keys) {
  return keys.any!(key => json.isInteger(key));
}
// #endregion noValue
// #endregion any

// #region is
// #region value
bool isInteger(Json json, string key, int value) {
  return json.hasKey(key) && json[key].isInteger(value);
}
// #endregion value

// #region noValue
bool isInteger(Json json, string key) {
  return json.hasKey(key) && json[key].isInteger;
}
// #endregion noValue
// #endregion is
// #endregion key

// #region scalar
// #region value
bool isInteger(Json json, int value) {
  return (value.isInteger) && (value.getInteger == value);
}
// #endregion value

// #region noValue
bool isInteger(Json json) {
  return (value.type == Json.Type.int_);
}
// #endregion noValue

// #region get
bool getInteger(Json json, size_t index, int defaultValue = 0) {
  return json.isInteger(index) ? json[index].get!(int) : defaultValue;
}

bool getInteger(Json json, string key, int defaultValue = 0) {
  return json.isInteger(key) ? json[key].get!(int) : defaultValue;
}

bool getInteger(Json json, int defaultValue = 0) {
  return json.isInteger ? json.get!(int) : defaultValue;
}
// #endregion get
// #endregion scalar

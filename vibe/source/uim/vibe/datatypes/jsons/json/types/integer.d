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
bool allInteger(Json json, string[][] paths) {
  return paths.any!(path => json.isInteger(path));
}
///
unittest {
  // Test allInteger with string[][] paths - empty paths
  Json json1 = Json.emptyObject;
  string[][] emptyPaths = [];
  assert(!json1.allInteger(emptyPaths));

  // Test allInteger with string[][] paths - single valid integer path
  Json json2 = Json.emptyObject;
  json2["a"] = Json(42);
  string[][] paths = [["a"]];
  assert(json2.allInteger(paths));

  // Test allInteger with string[][] paths - multiple valid integer paths
  Json json3 = Json.emptyObject;
  json3["a"] = Json(10);
  json3["b"] = Json(20);
  string[][] paths = [["a"], ["b"]];
  assert(json3.allInteger(paths));

  // Test allInteger with string[][] paths - mixed types (should return true if any is integer)
  Json json4 = Json.emptyObject;
  json4["a"] = Json(10);
  json4["b"] = Json("text");
  string[][] paths = [["a"], ["b"]];
  assert(json4.allInteger(paths));

  // Test allInteger with string[][] paths - no integers
  Json json5 = Json.emptyObject;
  json5["a"] = Json("text");
  json5["b"] = Json(3.14);
  string[][] paths = [["a"], ["b"]];
  assert(!json5.allInteger(paths));
  
  // Test allInteger with string[][] paths - nested paths
  Json json6 = Json.emptyObject;
  json6["outer"] = Json.emptyObject;
  json6["outer"]["inner"] = Json(100);
  string[][] paths = [["outer", "inner"]];
  assert(json6.allInteger(paths));

  // Test allInteger with string[][] paths - non-existent paths
  Json json7 = Json.emptyObject;
  json7["a"] = Json(10);
  string[][] paths = [["nonexistent"]];
  assert(!json7.allInteger(paths));

  // Test allInteger with string[][] paths and value - matching value
  Json json8 = Json.emptyObject;
  json8["a"] = Json(42);
  json8["b"] = Json(42);
  string[][] paths = [["a"], ["b"]];
  assert(json8.allInteger(paths, 42));

  // Test allInteger with string[][] paths and value - non-matching value
  Json json9 = Json.emptyObject;
  json9["a"] = Json(10);
  json9["b"] = Json(20);
  string[][] paths = [["a"], ["b"]];
  assert(!json9.allInteger(paths, 42));

  // Test allInteger with string[][] paths and value - partial match
  Json json10 = Json.emptyObject;
  json10["a"] = Json(42);
  json10["b"] = Json(10);
  string[][] paths = [["a"], ["b"]];
  assert(!json10.allInteger(paths, 42));
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
bool allInteger(Json json, string[][] paths, int value) {
  return paths.any!(path => json.isInteger(path) && json.getInteger(path) == value);
}
// #endregion value
// #endregion all

// #region any
bool anyInteger(Json json, string[][] paths) {
  return paths.any!(path => json.isInteger(path));
}
// #endregion any

// #region is
bool isInteger(Json json, string[] path, int value) {
  return json.isInteger(path) && json.getInteger(path) == value;
}

bool isInteger(Json json, string[] path) {
  if (!json.hasPath(path)) {
    return false;
  }

  if (path.length == 1) {
    return json.isInteger(path[0]);
  }

  return json[path[0]].isInteger(path[1 .. $]);
}
// #endregion is
// #endregion path

// #region key
bool allInteger(Json json, string[] keys) {
  return keys.any!(key => json.isInteger(key));
}

bool allInteger(Json json, string[] keys, int value) {
  return keys.any!(key => json.isInteger(key) && json.getInteger(key) == value);
}
bool anyInteger(Json json, string[] keys) {
  return keys.any!(key => json.isInteger(key));
}

bool isInteger(Json json, string key) {
  return json.hasKey(key) && json[key].isInteger;
}
/// 
unittest {
  assert(!Json(true).isInteger);
  assert(Json(10).isInteger);
  assert(!Json(1.1).isInteger);
  assert(!Json("text").isInteger);

  Json map = Json.emptyObject;
  map["a"] = Json(1);
  map["b"] = Json(2);
  map["c"] = Json(3.0);

  assert(map.isInteger("a") && map.isInteger("b"));
  assert(!map.isInteger("c"));

  assert(map.allInteger(["a", "b"]));
  assert(map.anyInteger(["a", "b"]));

  map["b"] = Json("B");
  assert(map.isInteger("a"));
  assert(!map.isInteger("b") && !map.isInteger("c"));

  assert(!map.allInteger(["a", "b"]));
  assert(map.anyInteger(["a", "b"]));

  map["a"] = Json("A");
  assert(!map.isInteger("a") && !map.isInteger("b") && !map.isInteger("c"));

  assert(!map.allInteger(["a", "b"]));
  assert(!map.anyInteger(["a", "b"]));

  // Json[]
  auto list = [Json(1), Json(2)];
  assert(list[0].isInteger && list[1].isInteger);

  assert(list.allInteger);
  assert(list.anyInteger);

  list[1] = Json(2.0);
  assert(list[0].isInteger && !list[1].isInteger);

  assert(!list.allInteger);
  assert(list.anyInteger);

  list[0] = Json(1.0);
  assert(!list[0].isInteger && !list[1].isInteger);
  assert(!list.allInteger);
  assert(!list.anyInteger);
}
// #endregion key

// #region value
bool isInteger(Json value) {
  return (value.type == Json.Type.int_);
}
// #endregion value

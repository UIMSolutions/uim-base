/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.types.integers.is_;

import uim.root;

mixin(Version!("test_uim_root"));

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
  string[][] paths1 = []; // emptyPaths
  assert(!json1.isAllInteger(paths1));

  // Test isAllInteger with string[][] paths - single valid integer path
  Json json2 = Json.emptyObject;
  json2["a"] = Json(42);
  string[][] paths2 = [["a"]];
  assert(json2.isAllInteger(paths2));

  // Test isAllInteger with string[][] paths - multiple valid integer paths
  Json json3 = Json.emptyObject;
  json3["a"] = Json(10);
  json3["b"] = Json(20);
  string[][] paths3 = [["a"], ["b"]];
  assert(json3.isAllInteger(paths));

  // Test isAllInteger with string[][] paths - mixed types (should return true if any is integer)
  Json json4 = Json.emptyObject;
  json4["a"] = Json(10);
  json4["b"] = Json("text");
  string[][] paths4 = [["a"], ["b"]];
  assert(json4.isAllInteger(paths4));

  // Test isAllInteger with string[][] paths - no integers
  Json json5 = Json.emptyObject;
  json5["a"] = Json("text");
  json5["b"] = Json(3.14);
  string[][] paths5 = [["a"], ["b"]];
  assert(!json5.isAllInteger(paths5));

  // Test isAllInteger with string[][] paths - nested paths
  Json json6 = Json.emptyObject;
  json6["outer"] = Json.emptyObject;
  json6["outer"]["inner"] = Json(100);
  string[][] paths6 = [["outer", "inner"]];
  assert(json6.isAllInteger(paths6));

  // Test isAllInteger with string[][] paths - non-existent paths
  Json json7 = Json.emptyObject;
  json7["a"] = Json(10);
  string[][] paths7 = [["nonexistent"]];
  assert(!json7.isAllInteger(paths7));

  // Test isAllInteger with string[][] paths and value - matching value
  Json json8 = Json.emptyObject;
  json8["a"] = Json(42);
  json8["b"] = Json(42);
  string[][] paths8 = [["a"], ["b"]];
  assert(json8.isAllInteger(paths8, 42));

  // Test isAllInteger with string[][] paths and value - non-matching value
  Json json9 = Json.emptyObject;
  json9["a"] = Json(10);
  json9["b"] = Json(20);
  string[][] paths9 = [["a"], ["b"]];
  assert(!json9.isAllInteger(paths9, 42));

  // Test isAllInteger with string[][] paths and value - partial match
  Json json10 = Json.emptyObject;
  json10["a"] = Json(42);
  json10["b"] = Json(10);
  string[][] paths10 = [["a"], ["b"]];
  assert(!json10.isAllInteger(paths10, 42));
}
// #endregion noValue

// #endregion all

// #region any
bool isAnyInteger(Json json, string[][] paths) {
  return paths.any!(path => json.isInteger(path));
}

// #endregion any

// #region is
// #region noValue
bool isInteger(Json json, string[] path) {
  return json.getPath(path).isInteger;
}
// #endregion noValue

// #endregion is
// #endregion path

// #region key
// #region all
bool isAllInteger(Json json, string[] keys) {
  return keys.any!(key => json.isInteger(key));
}

// #region noValue
bool isAnyInteger(Json json, string[] keys) {
  return keys.any!(key => json.isInteger(key));
}
// #endregion noValue
// #endregion any


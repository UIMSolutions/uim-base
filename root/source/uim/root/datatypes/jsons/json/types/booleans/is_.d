/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.types.booleans.is_;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

// #region path
// #region all
// #region value
/** 
  * Checks if the given JSON value at the specified paths is of boolean type.
  *
  * Params:
  *   json = The JSON value to check.
  *   paths = The paths within the JSON object to check.
  *   value = The boolean value to match.
  *
  * Returns:
  *   `true` if the JSON value at the specified paths is a boolean, `false` otherwise.
  */
bool isAllBoolean(Json json, string[][] paths, bool value) {
  return paths.all!(path => json.isBoolean(path, value));
}
///
unittest {
  // Test with all paths having the expected boolean value
  auto json1 = Json.emptyObject;
  json1["a"]["b"]["c"] = true;
  json1["x"]["y"] = true;
  json1["p"]["q"]["r"] = true;

  assert(isAllBoolean(json1, [["a", "b", "c"], ["x", "y"], ["p", "q", "r"]], true),
    "Should be true: all paths contain true");

  assert(!isAllBoolean(json1, [["a", "b", "c"], ["x", "y"], ["p", "q", "r"]], false),
    "Should be false: all paths contain true, not false");

  // Test with mixed boolean values
  auto json2 = Json.emptyObject;
  json2["a"]["b"] = true;
  json2["x"]["y"] = false;
  json2["p"]["q"] = true;

  assert(!isAllBoolean(json2, [["a", "b"], ["x", "y"], ["p", "q"]], true),
    "Should be false: not all paths are true");

  assert(!isAllBoolean(json2, [["a", "b"], ["x", "y"], ["p", "q"]], false),
    "Should be false: not all paths are false");

  // Test with all false values
  auto json3 = Json.emptyObject;
  json3["a"]["b"] = false;
  json3["x"]["y"]["z"] = false;

  assert(isAllBoolean(json3, [["a", "b"], ["x", "y", "z"]], false),
    "Should be true: all paths are false");

  assert(!isAllBoolean(json3, [["a", "b"], ["x", "y", "z"]], true),
    "Should be false: all paths are false, not true");

  // Test with non-boolean values
  auto json4 = Json.emptyObject;
  json4["a"]["b"] = true;
  json4["x"]["y"] = "not a boolean";

  assert(!isAllBoolean(json4, [["a", "b"], ["x", "y"]], true),
    "Should be false: one path is not a boolean");

  // Test with non-existent paths
  auto json5 = Json.emptyObject;
  json5["a"]["b"] = true;

  assert(!isAllBoolean(json5, [["a", "b"], ["x", "y"]], true),
    "Should be false: one path doesn't exist");

  // Test with empty paths array
  auto json6 = Json.emptyObject;
  json6["a"] = true;

  assert(isAllBoolean(json6, cast(string[][])[], true),
    "Should be true: empty paths array (vacuous truth)");

  // Test with single path
  auto json7 = Json.emptyObject;
  json7["a"]["b"]["c"] = true;

  assert(isAllBoolean(json7, [["a", "b", "c"]], true),
    "Should be true: single path with true");

  assert(!isAllBoolean(json7, [["a", "b", "c"]], false),
    "Should be false: single path is true, not false");
}
// #endregion value

// #region noValue
/** 
  * Checks if the given JSON value at the specified paths is of boolean type.
  *
  * Params:
  *   json = The JSON value to check.
  *   paths = The paths within the JSON object to check.
  *
  * Returns:
  *   `true` if the JSON value at the specified paths is a boolean, `false` otherwise.
  */
bool isAllBoolean(Json json, string[][] paths) {
  return paths.any!(path => json.isBoolean(path));
}
///
unittest {
  // Test with paths where at least one is boolean
  auto json1 = Json.emptyObject;
  json1["a"]["b"]["c"] = true;
  json1["x"]["y"] = "not a boolean";
  json1["p"]["q"] = 123;

  assert(isAllBoolean(json1, [["a", "b", "c"], ["x", "y"], ["p", "q"]]),
    "Should be true: at least one path contains a boolean");

  // Test with no boolean paths
  auto json2 = Json.emptyObject;
  json2["a"]["b"] = "string";
  json2["x"]["y"] = 42;
  json2["p"]["q"]["r"] = Json.emptyArray;

  assert(!isAllBoolean(json2, [["a", "b"], ["x", "y"], ["p", "q", "r"]]),
    "Should be false: no paths contain booleans");

  // Test with all paths containing booleans
  auto json3 = Json.emptyObject;
  json3["a"]["b"] = true;
  json3["x"]["y"]["z"] = false;
  json3["p"] = true;

  assert(isAllBoolean(json3, [["a", "b"], ["x", "y", "z"], ["p"]]),
    "Should be true: all paths contain booleans");

  // Test with empty paths array
  auto json4 = Json.emptyObject;
  json4["a"] = true;

  assert(!isAllBoolean(json4, cast(string[][])[]),
    "Should be false: empty paths array");

  // Test with non-existent paths
  auto json5 = Json.emptyObject;
  json5["a"]["b"] = true;

  assert(!isAllBoolean(json5, [["x", "y", "z"], ["p", "q"]]),
    "Should be false: paths don't exist");

  // Test with mix of existent and non-existent paths
  auto json6 = Json.emptyObject;
  json6["a"]["b"] = false;

  assert(isAllBoolean(json6, [["a", "b"], ["x", "y"]]),
    "Should be true: at least one path exists and is boolean");

  // Test with single path containing boolean
  auto json7 = Json.emptyObject;
  json7["a"]["b"]["c"] = true;

  assert(isAllBoolean(json7, [["a", "b", "c"]]),
    "Should be true: single path is boolean");

  // Test with single path not containing boolean
  auto json8 = Json.emptyObject;
  json8["a"]["b"] = "text";

  assert(!isAllBoolean(json8, [["a", "b"]]),
    "Should be false: single path is not boolean");
}
// #endregion noValue
// #endregion all

// #region any
// #region value
/** 
  * Checks if any of the given JSON value at the specified paths is of boolean type.
  *
  * Params:
  *   json = The JSON value to check.
  *   paths = The paths within the JSON object to check.
  *   value = The boolean value to match.
  *
  * Returns:
  *   `true` if the JSON value at the specified paths is a boolean, `false` otherwise.
  */
bool isAnyBoolean(Json json, string[][] paths, bool value) {
  return paths.any!(path => json.isBoolean(path, value));
}
///
unittest {
  // Test: at least one path contains a boolean
  auto json1 = Json.emptyObject;
  json1["a"]["b"] = true;
  json1["x"]["y"] = "not a boolean";
  json1["p"]["q"] = 123;
  assert(isAnyBoolean(json1, [["a", "b"], ["x", "y"], ["p", "q"]]), "Should be true: one path is boolean");

  // Test: no path contains a boolean
  auto json2 = Json.emptyObject;
  json2["a"]["b"] = "string";
  json2["x"]["y"] = 42;
  json2["p"]["q"]["r"] = Json.emptyArray;
  assert(!isAnyBoolean(json2, [["a", "b"], ["x", "y"], ["p", "q", "r"]]), "Should be false: no path is boolean");

  // Test: all paths contain booleans
  auto json3 = Json.emptyObject;
  json3["a"]["b"] = true;
  json3["x"]["y"]["z"] = false;
  json3["p"] = true;
  assert(isAnyBoolean(json3, [["a", "b"], ["x", "y", "z"], ["p"]]), "Should be true: all paths are boolean");

  // Test: empty paths array
  auto json4 = Json.emptyObject;
  json4["a"] = true;
  assert(!isAnyBoolean(json4, cast(string[][])[]), "Should be false: empty paths array");

  // Test: non-existent paths
  auto json5 = Json.emptyObject;
  json5["a"]["b"] = true;
  assert(!isAnyBoolean(json5, [["x", "y", "z"], ["p", "q"]]), "Should be false: paths don't exist");

  // Test: mix of existent and non-existent paths
  auto json6 = Json.emptyObject;
  json6["a"]["b"] = false;
  assert(isAnyBoolean(json6, [["a", "b"], ["x", "y"]]), "Should be true: one path exists and is boolean");

  // Test: single path containing boolean
  auto json7 = Json.emptyObject;
  json7["a"]["b"]["c"] = true;
  assert(isAnyBoolean(json7, [["a", "b", "c"]]), "Should be true: single path is boolean");

  // Test: single path not containing boolean
  auto json8 = Json.emptyObject;
  json8["a"]["b"] = "text";
  assert(!isAnyBoolean(json8, [["a", "b"]]), "Should be false: single path is not boolean");
}
// #endregion value

// #region noValue
/**
  * Checks if any of the given JSON value at the specified paths is of boolean type.
  *
  * Params:
  *   json = The JSON value to check.
  *   paths = The paths within the JSON object to check.
  *
  * Returns:
  *   `true` if the JSON value at the specified paths is a boolean, `false` otherwise.
  */
bool isAnyBoolean(Json json, string[][] paths) {
  return paths.any!(path => json.isBoolean(path));
}
///
unittest {
  // Test: at least one path contains a boolean
  auto json1 = Json.emptyObject;
  json1["a"]["b"] = true;
  json1["x"]["y"] = "not a boolean";
  json1["p"]["q"] = 123;
  assert(isAnyBoolean(json1, [["a", "b"], ["x", "y"], ["p", "q"]]), "Should be true: one path is boolean");

  // Test: no path contains a boolean
  auto json2 = Json.emptyObject;
  json2["a"]["b"] = "string";
  json2["x"]["y"] = 42;
  json2["p"]["q"]["r"] = Json.emptyArray;
  assert(!isAnyBoolean(json2, [["a", "b"], ["x", "y"], ["p", "q", "r"]]), "Should be false: no path is boolean");

  // Test: all paths contain booleans
  auto json3 = Json.emptyObject;
  json3["a"]["b"] = true;
  json3["x"]["y"]["z"] = false;
  json3["p"] = true;
  assert(isAnyBoolean(json3, [["a", "b"], ["x", "y", "z"], ["p"]]), "Should be true: all paths are boolean");

  // Test: empty paths array
  auto json4 = Json.emptyObject;
  json4["a"] = true;
  assert(!isAnyBoolean(json4, cast(string[][])[]), "Should be false: empty paths array");

  // Test: non-existent paths
  auto json5 = Json.emptyObject;
  json5["a"]["b"] = true;
  assert(!isAnyBoolean(json5, [["x", "y", "z"], ["p", "q"]]), "Should be false: paths don't exist");

  // Test: mix of existent and non-existent paths
  auto json6 = Json.emptyObject;
  json6["a"]["b"] = false;
  assert(isAnyBoolean(json6, [["a", "b"], ["x", "y"]]), "Should be true: one path exists and is boolean");

  // Test: single path containing boolean
  auto json7 = Json.emptyObject;
  json7["a"]["b"]["c"] = true;
  assert(isAnyBoolean(json7, [["a", "b", "c"]]), "Should be true: single path is boolean");

  // Test: single path not containing boolean
  auto json8 = Json.emptyObject;
  json8["a"]["b"] = "text";
  assert(!isAnyBoolean(json8, [["a", "b"]]), "Should be false: single path is not boolean");
}
// #endregion noValue
// #endregion any

// #region is
/** 
  * Checks if the given JSON value at the specified path is of boolean type.
  *
  * Params:
  *   json = The JSON value to check.
  *   path = The path within the JSON object to check.
  *
  * Returns:
  *   `true` if the JSON value at the specified path is a boolean, `false` otherwise.
  */
bool isBoolean(Json json, string[] path) {
  return json.getPath(path).isBoolean(path[0]);
}
// #endregion is
// #endregion path

// #region key
// #region all
/** 
  * Checks if the given JSON value at the specified keys is of boolean type.
  *
  * Params:
  *   json = The JSON value to check.
  *   keys = The keys within the JSON object to check.
  *
  * Returns:
  *   `true` if the JSON value at the specified keys is a boolean, `false` otherwise.
  */
bool isAllBoolean(Json json, string[] keys) {
  return keys.all!(key => json.isBoolean(key));
}
///
unittest {
  // Test: all keys are boolean (true/false)
  auto json1 = Json.emptyObject;
  json1["a"] = true;
  json1["b"] = false;
  json1["c"] = true;
  assert(isAllBoolean(json1, ["a", "b", "c"]), "All keys are boolean");

  // Test: some keys are not boolean
  auto json2 = Json.emptyObject;
  json2["x"] = true;
  json2["y"] = "string";
  json2["z"] = 42;
  assert(!isAllBoolean(json2, ["x", "y", "z"]), "Not all keys are boolean");

  // Test: no keys are boolean
  auto json3 = Json.emptyObject;
  json3["a"] = "text";
  json3["b"] = 123;
  assert(!isAllBoolean(json3, ["a", "b"]), "No keys are boolean");

  // Test: non-existent key
  auto json4 = Json.emptyObject;
  json4["a"] = true;
  assert(!isAllBoolean(json4, ["a", "b"]), "One key does not exist");

  // Test: empty keys array (should be vacuously true)
  auto json5 = Json.emptyObject;
  json5["a"] = false;
  assert(isAllBoolean(json5, cast(string[])[]), "Empty keys array should return true");

  // Test: single key is boolean
  auto json6 = Json.emptyObject;
  json6["single"] = false;
  assert(isAllBoolean(json6, ["single"]), "Single key is boolean");

  // Test: single key is not boolean
  auto json7 = Json.emptyObject;
  json7["single"] = "not boolean";
  assert(!isAllBoolean(json7, ["single"]), "Single key is not boolean");
}
// #endregion noValue
// #endregion all

// #region any
// #region noValue
/** 
  * Checks if any of the given JSON value at the specified keys is of boolean type.
  *
  * Params:
  *   json = The JSON value to check.
  *   keys = The keys within the JSON object to check.
  *
  * Returns:
  *   `true` if the JSON value at the specified keys is a boolean, `false` otherwise.
  */
bool isAnyBoolean(Json json, string[] keys) {
  return keys.any!(key => json.isBoolean(key));
}
///

unittest {
  // Test: at least one key is boolean
  auto json1 = Json.emptyObject;
  json1["a"] = true;
  json1["b"] = "not a boolean";
  json1["c"] = 123;
  assert(isAnyBoolean(json1, ["a", "b", "c"]), "Should be true: one key is boolean");

  // Test: no key is boolean
  auto json2 = Json.emptyObject;
  json2["x"] = "string";
  json2["y"] = 42;
  json2["z"] = Json.emptyArray;
  assert(!isAnyBoolean(json2, ["x", "y", "z"]), "Should be false: no key is boolean");

  // Test: all keys are boolean
  auto json3 = Json.emptyObject;
  json3["a"] = true;
  json3["b"] = false;
  json3["c"] = true;
  assert(isAnyBoolean(json3, ["a", "b", "c"]), "Should be true: all keys are boolean");

  // Test: empty keys array
  auto json4 = Json.emptyObject;
  json4["a"] = true;
  assert(!isAnyBoolean(json4, cast(string[])[]), "Should be false: empty keys array");

  // Test: non-existent keys
  auto json5 = Json.emptyObject;
  json5["a"] = true;
  assert(!isAnyBoolean(json5, ["x", "y", "z"]), "Should be false: keys don't exist");

  // Test: mix of existent and non-existent keys
  auto json6 = Json.emptyObject;
  json6["a"] = false;
  assert(isAnyBoolean(json6, ["a", "b"]), "Should be true: one key exists and is boolean");

  // Test: single key that is boolean
  auto json7 = Json.emptyObject;
  json7["single"] = true;
  assert(isAnyBoolean(json7, ["single"]), "Should be true: single key is boolean");

  // Test: single key that is not boolean
  auto json8 = Json.emptyObject;
  json8["single"] = "text";
  assert(!isAnyBoolean(json8, ["single"]), "Should be false: single key is not boolean");

  // Test: multiple keys, only last one is boolean
  auto json9 = Json.emptyObject;
  json9["a"] = 1;
  json9["b"] = "string";
  json9["c"] = false;
  assert(isAnyBoolean(json9, ["a", "b", "c"]), "Should be true: last key is boolean");

  // Test: multiple keys, only first one is boolean
  auto json10 = Json.emptyObject;
  json10["a"] = true;
  json10["b"] = 42;
  json10["c"] = Json.emptyObject;
  assert(isAnyBoolean(json10, ["a", "b", "c"]), "Should be true: first key is boolean");
}
// #endregion noValue
// #endregion any

// #region is
/**
  * Checks if the given JSON value at the specified key is of boolean type.
  *
  * Params:
  *   json = The JSON value to check.
  *   key  = The key within the JSON object to check.
  *
  * Returns:
  *   `true` if the JSON value at the specified key is a boolean, `false` otherwise.
  */
bool isBoolean(Json json, string key) {
  return json.getKey(key).isBoolean;
}
///
unittest {
  // Test isBoolean with actual boolean values
  assert(isBoolean(Json(true)), "Should be true: Json(true) is a boolean");
  assert(isBoolean(Json(false)), "Should be true: Json(false) is a boolean");

  // Test isBoolean with non-boolean values
  assert(!isBoolean(Json(1)), "Should be false: Json(1) is not a boolean");
  assert(!isBoolean(Json(0)), "Should be false: Json(0) is not a boolean");
  assert(!isBoolean(Json("true")), "Should be false: Json(\"true\") is not a boolean");
  assert(!isBoolean(Json("false")), "Should be false: Json(\"false\") is not a boolean");
  assert(!isBoolean(Json("string")), "Should be false: Json(\"string\") is not a boolean");
  assert(!isBoolean(Json(1.0)), "Should be false: Json(1.0) is not a boolean");

  // Test isBoolean with empty array and object
  assert(!isBoolean(Json.emptyArray), "Should be false: empty array is not a boolean");
  assert(!isBoolean(Json.emptyObject), "Should be false: empty object is not a boolean");
}
// #endregion noValue
// #endregion is

// #region get
// #endregion get
// #endregion key

// #region scalar
// #region is
// #region value
bool isBoolean(Json json, bool value) {
  return json.isBoolean && json.getBoolean == value;
}
// #region noValue

// #region value
bool isBoolean(Json json, size_t index) {
  return json.isArray && json[index].isBoolean;
}

// #endregion value
// #endregion is
// #endregion scalar

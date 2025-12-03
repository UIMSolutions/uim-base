/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.json.types.boolean;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region allBoolean
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
bool allBoolean(Json json, string[][] paths, bool value) {
  return paths.all!(path => json.isBoolean(path) && json.getBoolean(path) == value);
}
///
unittest {
  // Test with all paths having the expected boolean value
  auto json1 = Json.emptyObject;
  json1["a"]["b"]["c"] = true;
  json1["x"]["y"] = true;
  json1["p"]["q"]["r"] = true;

  assert(allBoolean(json1, [["a", "b", "c"], ["x", "y"], ["p", "q", "r"]], true),
    "Should be true: all paths contain true");

  assert(!allBoolean(json1, [["a", "b", "c"], ["x", "y"], ["p", "q", "r"]], false),
    "Should be false: all paths contain true, not false");

  // Test with mixed boolean values
  auto json2 = Json.emptyObject;
  json2["a"]["b"] = true;
  json2["x"]["y"] = false;
  json2["p"]["q"] = true;

  assert(!allBoolean(json2, [["a", "b"], ["x", "y"], ["p", "q"]], true),
    "Should be false: not all paths are true");

  assert(!allBoolean(json2, [["a", "b"], ["x", "y"], ["p", "q"]], false),
    "Should be false: not all paths are false");

  // Test with all false values
  auto json3 = Json.emptyObject;
  json3["a"]["b"] = false;
  json3["x"]["y"]["z"] = false;

  assert(allBoolean(json3, [["a", "b"], ["x", "y", "z"]], false),
    "Should be true: all paths are false");

  assert(!allBoolean(json3, [["a", "b"], ["x", "y", "z"]], true),
    "Should be false: all paths are false, not true");

  // Test with non-boolean values
  auto json4 = Json.emptyObject;
  json4["a"]["b"] = true;
  json4["x"]["y"] = "not a boolean";

  assert(!allBoolean(json4, [["a", "b"], ["x", "y"]], true),
    "Should be false: one path is not a boolean");

  // Test with non-existent paths
  auto json5 = Json.emptyObject;
  json5["a"]["b"] = true;

  assert(!allBoolean(json5, [["a", "b"], ["x", "y"]], true),
    "Should be false: one path doesn't exist");

  // Test with empty paths array
  auto json6 = Json.emptyObject;
  json6["a"] = true;

  assert(allBoolean(json6, cast(string[][])[], true),
    "Should be true: empty paths array (vacuous truth)");

  // Test with single path
  auto json7 = Json.emptyObject;
  json7["a"]["b"]["c"] = true;

  assert(allBoolean(json7, [["a", "b", "c"]], true),
    "Should be true: single path with true");

  assert(!allBoolean(json7, [["a", "b", "c"]], false),
    "Should be false: single path is true, not false");
}

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
bool allBoolean(Json json, string[][] paths) {
  return paths.any!(path => json.isBoolean(path));
}
///
unittest {
  // Test with paths where at least one is boolean
  auto json1 = Json.emptyObject;
  json1["a"]["b"]["c"] = true;
  json1["x"]["y"] = "not a boolean";
  json1["p"]["q"] = 123;

  assert(allBoolean(json1, [["a", "b", "c"], ["x", "y"], ["p", "q"]]),
    "Should be true: at least one path contains a boolean");

  // Test with no boolean paths
  auto json2 = Json.emptyObject;
  json2["a"]["b"] = "string";
  json2["x"]["y"] = 42;
  json2["p"]["q"]["r"] = Json.emptyArray;

  assert(!allBoolean(json2, [["a", "b"], ["x", "y"], ["p", "q", "r"]]),
    "Should be false: no paths contain booleans");

  // Test with all paths containing booleans
  auto json3 = Json.emptyObject;
  json3["a"]["b"] = true;
  json3["x"]["y"]["z"] = false;
  json3["p"] = true;

  assert(allBoolean(json3, [["a", "b"], ["x", "y", "z"], ["p"]]),
    "Should be true: all paths contain booleans");

  // Test with empty paths array
  auto json4 = Json.emptyObject;
  json4["a"] = true;

  assert(!allBoolean(json4, cast(string[][])[]),
    "Should be false: empty paths array");

  // Test with non-existent paths
  auto json5 = Json.emptyObject;
  json5["a"]["b"] = true;

  assert(!allBoolean(json5, [["x", "y", "z"], ["p", "q"]]),
    "Should be false: paths don't exist");

  // Test with mix of existent and non-existent paths
  auto json6 = Json.emptyObject;
  json6["a"]["b"] = false;

  assert(allBoolean(json6, [["a", "b"], ["x", "y"]]),
    "Should be true: at least one path exists and is boolean");

  // Test with single path containing boolean
  auto json7 = Json.emptyObject;
  json7["a"]["b"]["c"] = true;

  assert(allBoolean(json7, [["a", "b", "c"]]),
    "Should be true: single path is boolean");

  // Test with single path not containing boolean
  auto json8 = Json.emptyObject;
  json8["a"]["b"] = "text";

  assert(!allBoolean(json8, [["a", "b"]]),
    "Should be false: single path is not boolean");
}

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
bool allBoolean(Json json, string[] keys, bool value) {
  return keys.all!(key => json.isBoolean(key) && json.getBoolean(key) == value);
}
///
unittest {
  // Test: all keys have the expected boolean value (true)
  auto json1 = Json.emptyObject;
  json1["a"] = true;
  json1["b"] = true;
  json1["c"] = true;
  assert(allBoolean(json1, ["a", "b", "c"], true), "All keys should be true");

  // Test: all keys have the expected boolean value (false)
  auto json2 = Json.emptyObject;
  json2["x"] = false;
  json2["y"] = false;
  assert(allBoolean(json2, ["x", "y"], false), "All keys should be false");

  // Test: mixed boolean values
  auto json3 = Json.emptyObject;
  json3["a"] = true;
  json3["b"] = false;
  assert(!allBoolean(json3, ["a", "b"], true), "Not all keys are true");
  assert(!allBoolean(json3, ["a", "b"], false), "Not all keys are false");

  // Test: non-boolean value among keys
  auto json4 = Json.emptyObject;
  json4["a"] = true;
  json4["b"] = "not a boolean";
  assert(!allBoolean(json4, ["a", "b"], true), "One key is not a boolean");

  // Test: non-existent key
  auto json5 = Json.emptyObject;
  json5["a"] = true;
  assert(!allBoolean(json5, ["a", "b"], true), "One key does not exist");

  // Test: empty keys array (should be vacuously true)
  auto json6 = Json.emptyObject;
  json6["a"] = false;
  assert(allBoolean(json6, cast(string[])[], false), "Empty keys array should return true");

  // Test: single key with expected value
  auto json7 = Json.emptyObject;
  json7["single"] = true;
  assert(allBoolean(json7, ["single"], true), "Single key is true");
  assert(!allBoolean(json7, ["single"], false), "Single key is not false");
}

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
bool allBoolean(Json json, string[] keys) {
  return keys.all!(key => json.isBoolean(key));
}
///
unittest {
  // Test: all keys are boolean (true/false)
  auto json1 = Json.emptyObject;
  json1["a"] = true;
  json1["b"] = false;
  json1["c"] = true;
  assert(allBoolean(json1, ["a", "b", "c"]), "All keys are boolean");

  // Test: some keys are not boolean
  auto json2 = Json.emptyObject;
  json2["x"] = true;
  json2["y"] = "string";
  json2["z"] = 42;
  assert(!allBoolean(json2, ["x", "y", "z"]), "Not all keys are boolean");

  // Test: no keys are boolean
  auto json3 = Json.emptyObject;
  json3["a"] = "text";
  json3["b"] = 123;
  assert(!allBoolean(json3, ["a", "b"]), "No keys are boolean");

  // Test: non-existent key
  auto json4 = Json.emptyObject;
  json4["a"] = true;
  assert(!allBoolean(json4, ["a", "b"]), "One key does not exist");

  // Test: empty keys array (should be vacuously true)
  auto json5 = Json.emptyObject;
  json5["a"] = false;
  assert(allBoolean(json5, cast(string[])[]), "Empty keys array should return true");

  // Test: single key is boolean
  auto json6 = Json.emptyObject;
  json6["single"] = false;
  assert(allBoolean(json6, ["single"]), "Single key is boolean");

  // Test: single key is not boolean
  auto json7 = Json.emptyObject;
  json7["single"] = "not boolean";
  assert(!allBoolean(json7, ["single"]), "Single key is not boolean");
}
// #endregion allBoolean

// #region anyBoolean
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
bool anyBoolean(Json json, string[][] paths, bool value) {
  return paths.any!(path => json.isBoolean(path) && json.getBoolean(path) == value);
}
///
unittest {
  // Test: at least one path contains a boolean
  auto json1 = Json.emptyObject;
  json1["a"]["b"] = true;
  json1["x"]["y"] = "not a boolean";
  json1["p"]["q"] = 123;
  assert(anyBoolean(json1, [["a", "b"], ["x", "y"], ["p", "q"]]), "Should be true: one path is boolean");

  // Test: no path contains a boolean
  auto json2 = Json.emptyObject;
  json2["a"]["b"] = "string";
  json2["x"]["y"] = 42;
  json2["p"]["q"]["r"] = Json.emptyArray;
  assert(!anyBoolean(json2, [["a", "b"], ["x", "y"], ["p", "q", "r"]]), "Should be false: no path is boolean");

  // Test: all paths contain booleans
  auto json3 = Json.emptyObject;
  json3["a"]["b"] = true;
  json3["x"]["y"]["z"] = false;
  json3["p"] = true;
  assert(anyBoolean(json3, [["a", "b"], ["x", "y", "z"], ["p"]]), "Should be true: all paths are boolean");

  // Test: empty paths array
  auto json4 = Json.emptyObject;
  json4["a"] = true;
  assert(!anyBoolean(json4, cast(string[][])[]), "Should be false: empty paths array");

  // Test: non-existent paths
  auto json5 = Json.emptyObject;
  json5["a"]["b"] = true;
  assert(!anyBoolean(json5, [["x", "y", "z"], ["p", "q"]]), "Should be false: paths don't exist");

  // Test: mix of existent and non-existent paths
  auto json6 = Json.emptyObject;
  json6["a"]["b"] = false;
  assert(anyBoolean(json6, [["a", "b"], ["x", "y"]]), "Should be true: one path exists and is boolean");

  // Test: single path containing boolean
  auto json7 = Json.emptyObject;
  json7["a"]["b"]["c"] = true;
  assert(anyBoolean(json7, [["a", "b", "c"]]), "Should be true: single path is boolean");

  // Test: single path not containing boolean
  auto json8 = Json.emptyObject;
  json8["a"]["b"] = "text";
  assert(!anyBoolean(json8, [["a", "b"]]), "Should be false: single path is not boolean");
}

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
bool anyBoolean(Json json, string[][] paths) {
  return paths.any!(path => json.isBoolean(path));
}
///
unittest {
  // Test: at least one path contains a boolean
  auto json1 = Json.emptyObject;
  json1["a"]["b"] = true;
  json1["x"]["y"] = "not a boolean";
  json1["p"]["q"] = 123;
  assert(anyBoolean(json1, [["a", "b"], ["x", "y"], ["p", "q"]]), "Should be true: one path is boolean");

  // Test: no path contains a boolean
  auto json2 = Json.emptyObject;
  json2["a"]["b"] = "string";
  json2["x"]["y"] = 42;
  json2["p"]["q"]["r"] = Json.emptyArray;
  assert(!anyBoolean(json2, [["a", "b"], ["x", "y"], ["p", "q", "r"]]), "Should be false: no path is boolean");

  // Test: all paths contain booleans
  auto json3 = Json.emptyObject;
  json3["a"]["b"] = true;
  json3["x"]["y"]["z"] = false;
  json3["p"] = true;
  assert(anyBoolean(json3, [["a", "b"], ["x", "y", "z"], ["p"]]), "Should be true: all paths are boolean");

  // Test: empty paths array
  auto json4 = Json.emptyObject;
  json4["a"] = true;
  assert(!anyBoolean(json4, cast(string[][])[]), "Should be false: empty paths array");

  // Test: non-existent paths
  auto json5 = Json.emptyObject;
  json5["a"]["b"] = true;
  assert(!anyBoolean(json5, [["x", "y", "z"], ["p", "q"]]), "Should be false: paths don't exist");

  // Test: mix of existent and non-existent paths
  auto json6 = Json.emptyObject;
  json6["a"]["b"] = false;
  assert(anyBoolean(json6, [["a", "b"], ["x", "y"]]), "Should be true: one path exists and is boolean");

  // Test: single path containing boolean
  auto json7 = Json.emptyObject;
  json7["a"]["b"]["c"] = true;
  assert(anyBoolean(json7, [["a", "b", "c"]]), "Should be true: single path is boolean");

  // Test: single path not containing boolean
  auto json8 = Json.emptyObject;
  json8["a"]["b"] = "text";
  assert(!anyBoolean(json8, [["a", "b"]]), "Should be false: single path is not boolean");
}

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
bool anyBoolean(Json json, string[] keys) {
  return keys.any!(key => json.isBoolean(key));
}
///

unittest {
  // Test: at least one key is boolean
  auto json1 = Json.emptyObject;
  json1["a"] = true;
  json1["b"] = "not a boolean";
  json1["c"] = 123;
  assert(anyBoolean(json1, ["a", "b", "c"]), "Should be true: one key is boolean");

  // Test: no key is boolean
  auto json2 = Json.emptyObject;
  json2["x"] = "string";
  json2["y"] = 42;
  json2["z"] = Json.emptyArray;
  assert(!anyBoolean(json2, ["x", "y", "z"]), "Should be false: no key is boolean");

  // Test: all keys are boolean
  auto json3 = Json.emptyObject;
  json3["a"] = true;
  json3["b"] = false;
  json3["c"] = true;
  assert(anyBoolean(json3, ["a", "b", "c"]), "Should be true: all keys are boolean");

  // Test: empty keys array
  auto json4 = Json.emptyObject;
  json4["a"] = true;
  assert(!anyBoolean(json4, cast(string[])[]), "Should be false: empty keys array");

  // Test: non-existent keys
  auto json5 = Json.emptyObject;
  json5["a"] = true;
  assert(!anyBoolean(json5, ["x", "y", "z"]), "Should be false: keys don't exist");

  // Test: mix of existent and non-existent keys
  auto json6 = Json.emptyObject;
  json6["a"] = false;
  assert(anyBoolean(json6, ["a", "b"]), "Should be true: one key exists and is boolean");

  // Test: single key that is boolean
  auto json7 = Json.emptyObject;
  json7["single"] = true;
  assert(anyBoolean(json7, ["single"]), "Should be true: single key is boolean");

  // Test: single key that is not boolean
  auto json8 = Json.emptyObject;
  json8["single"] = "text";
  assert(!anyBoolean(json8, ["single"]), "Should be false: single key is not boolean");

  // Test: multiple keys, only last one is boolean
  auto json9 = Json.emptyObject;
  json9["a"] = 1;
  json9["b"] = "string";
  json9["c"] = false;
  assert(anyBoolean(json9, ["a", "b", "c"]), "Should be true: last key is boolean");

  // Test: multiple keys, only first one is boolean
  auto json10 = Json.emptyObject;
  json10["a"] = true;
  json10["b"] = 42;
  json10["c"] = Json.emptyObject;
  assert(anyBoolean(json10, ["a", "b", "c"]), "Should be true: first key is boolean");
}
// #endregion anyBoolean

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
  if (!json.hasPath(path)) {
    return false;
  }

  if (path.length == 1) {
    return json.isBoolean(path[0]);
  }

  return json[path[0]].isBoolean(path[1 .. $]);
}

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
  return json.hasKey(key) && json[key].isBoolean;
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

/**
  * Checks if the given JSON value is of boolean type.
  *
  * Params:
  *   json = The JSON value to check.
  *
  * Returns:
  *   `true` if the JSON value is a boolean, `false` otherwise.
  */
bool isBoolean(Json json) {
  return (json.type == Json.Type.bool_);
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

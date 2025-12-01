/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.json.types.boolean;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

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

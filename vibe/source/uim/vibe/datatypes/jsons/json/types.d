/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.json.types;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region null
bool isNull(Json json, string key) {
  if (json.isNull) {
    return true;
  }

  return json.isObject && key in json ? json[key].isNull : true;
}

bool isNull(Json json, string[] path) {
  if (json.isNull || path.length == 0) {
    return true;
  }

  auto firstKey = path[0];
  if (json.isNull(firstKey)) {
    return true;
  }

  return path.length > 1 && json[firstKey].isNull(path[1 .. $]);
}

/** 
  * Checks if the given JSON value is null.
  *
  * Params:
  *   json = The JSON value to check.
  *
  * Returns:
  *   `true` if the JSON value is null, `false` otherwise.
  */
bool isNull(Json json) {
  return json == Json(null); 
}
/// 
unittest {
  assert(Json(null).isNull);
  assert(!Json.emptyObject.isNull);
  assert(!Json.emptyArray.isNull);

  auto json = parseJsonString(`{"a": "b", "c": {"d": 1}, "e": ["f", {"g": "h"}]}`);
  assert(json.isNull("x"));
  assert(!json.isNull("a"));

  assert(json.isNull(["x"]));
  assert(!json.isNull(["a"]));

  assert(json.isAllNull(["x", "y"]));
  assert(!json.isAllNull(["a", "y"]));
  assert(json.isAnyNull(["x", "y"]));
  assert(!json.isAnyNull(["a", "c"]));
}

// #endregion null

// #region boolean
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
  if (json.isNull || !json.isObject || !json.hasKey(key)) {
    return false;
  }
  return (json[key].isBoolean);
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
// #endregion boolean

// #region integer
bool isInteger(Json json, string[] path) {
  if (!json.hasPath(path)) {
    return false;
  }

  if (path.length == 1) {
    return json.isInteger(path[0]);
  }

  return json[path[0]].isInteger(path[1 .. $]);
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
// #endregion isInteger(Json)

bool isInteger(Json value) {
  return (value.type == Json.Type.int_);
}
// #endregion integer

// #region double
/// Check if the Json value is a double (floating-point number).
bool isDouble(Json value, bool strict = true) {
  if (!strict) {
    // check for boolean, integer, and string types
  }
  return (value.type == Json.Type.float_);
}

unittest {
  // Test with float value
  Json floatVal = Json(3.14);
  assert(isDouble(floatVal));
  assert(floatVal.isDouble);

  // Test with integer value
  Json intVal = Json(42);
  assert(!isDouble(intVal));
  assert(!intVal.isDouble);

  // Test with boolean value
  Json boolVal = Json(true);
  assert(!isDouble(boolVal));
  assert(!boolVal.isDouble);

  // Test with string value
  Json strVal = Json("test");
  assert(!isDouble(strVal));
  assert(!strVal.isDouble);

  // Test with null value
  Json nullVal = Json.init;
  assert(!isDouble(nullVal));
  assert(!nullVal.isDouble);

  // Test with array value
  Json arrVal = Json.emptyArray;
  assert(!isDouble(arrVal));
  assert(!arrVal.isDouble);

  // Test with object value
  Json objVal = Json.emptyObject;
  assert(!isDouble(objVal));
  assert(!objVal.isDouble);

  // Test with strict = false (should still only return true for float)
  assert(isDouble(floatVal, false));
  assert(!isDouble(intVal, false));
  assert(!isDouble(boolVal, false));
  assert(!isDouble(strVal, false));
}
// #endregion double
/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.json.booleans.isboolean;

import uim.vibe;

mixin(Version!("test_uim_vibe"));
@safe:

/** 
  * Checks if any element in the array is of boolean type.
  *
  * Params:
  *   values = The array to check.
  *
  * Returns:
  *   `true` if any element is a boolean, `false` otherwise.
  */
bool isAnyBoolean(Json[] values) {
  return values.any!(value => value.isBoolean);
}
///
unittest {
  // Test with no booleans
  Json[] array1 = [Json(1), Json("string"), Json(2.5)];
  assert(!isAnyBoolean(array1), "Should be false: no booleans present");

  // Test with one boolean at start
  Json[] array2 = [Json(true), Json(1), Json("string")];
  assert(isAnyBoolean(array2), "Should be true: boolean at index 0");

  // Test with one boolean at end
  Json[] arr3 = [Json(1), Json("string"), Json(false)];
  assert(isAnyBoolean(arr3), "Should be true: boolean at last index");

  // Test with multiple booleans
  Json[] arr4 = [Json(true), Json(false), Json(true)];
  assert(isAnyBoolean(arr4), "Should be true: all elements are booleans");

  // Test with empty array
  Json[] arr5 = [];
  assert(!isAnyBoolean(arr5), "Should be false: empty array");

  // Test with mixed types
  Json[] arr6 = [Json(1), Json(true), Json("string"), Json(false)];
  assert(isAnyBoolean(arr6), "Should be true: booleans present in array");
}

/** 
  * Checks if any specified elements in the map are of boolean type.
  *
  * Params:
  *   map = The map to check.
  *   keys = Optional keys to check within the map. If not provided, all elements are checked.
  *
  * Returns:
  *   `true` if any specified elements are booleans, `false` otherwise.
  *
  * Examples:
  * ```d
  * Json[string] map1 = ["a": Json(1), "b": Json(2), "c": Json(3)];
  * assert(!map1.isAnyBoolean); // false
  *
  * Json[string] map2 = ["a": Json(1), "b": Json(true), "c": Json(3)];
  * assert(map2.isAnyBoolean); // true
  *
  * Json[string] map3 = ["a": Json("a"), "b": Json("b"), "c": Json(false)];
  * assert(map3.isAnyBoolean); // true
  *
  * Json[string] map4 = ["a": Json(1), "b": Json(true), "c": Json(3)];
  * assert(map4.isAnyBoolean(["a", "b"])); // true
  * assert(!map4.isAnyBoolean(["a", "c"])); // false
  * ```
  */
bool isAnyBoolean(Json[string] map) {
  return map.byValue.array.isAnyBoolean;
}
///
unittest {
  // Test with no booleans in map
  Json[string] map1 = ["a": Json(1), "b": Json("string"), "c": Json(2.5)];
  assert(!map1.isAnyBoolean, "Should be false: no booleans present in map");

  // Test with one boolean value in map
  Json[string] map2 = ["a": Json(true), "b": Json(1), "c": Json("string")];
  assert(map2.isAnyBoolean, "Should be true: boolean present at key 'a'");

  // Test with boolean at last key
  Json[string] map3 = ["a": Json(1), "b": Json("string"), "c": Json(false)];
  assert(map3.isAnyBoolean, "Should be true: boolean present at key 'c'");

  // Test with multiple booleans
  Json[string] map4 = ["a": Json(true), "b": Json(false), "c": Json(true)];
  assert(isAnyBoolean(map4), "Should be true: all values are booleans");

  // Test with empty map
  Json[string] map5;
  assert(!isAnyBoolean(map5), "Should be false: empty map");

  // Test with mixed types
  Json[string] map6 = [
    "a": Json(1), "b": Json(true), "c": Json("string"), "d": Json(false)
  ];
  assert(isAnyBoolean(map6), "Should be true: booleans present in map");
}

/** 
  * Checks if any specified elements in the map are of boolean type.
  *
  * Params:
  *   map = The map to check.
  *   keys = Optional keys to check within the map. If not provided, all elements are checked.
  *
  * Returns:
  *   `true` if any specified elements are booleans, `false` otherwise.
  *
  * Examples:
  * ```d
  * Json[string] map1 = ["a": Json(1), "b": Json(2), "c": Json(3)];
  * assert(!map1.isAnyBoolean); // false
  *
  * Json[string] map2 = ["a": Json(1), "b": Json(true), "c": Json(3)];
  * assert(map2.isAnyBoolean); // true
  *
  * Json[string] map3 = ["a": Json("a"), "b": Json("b"), "c": Json(false)];
  * assert(map3.isAnyBoolean); // true
  *
  * Json[string] map4 = ["a": Json(1), "b": Json(true), "c": Json(3)];
  * assert(map4.isAnyBoolean(["a", "b"])); // true
  * assert(!map4.isAnyBoolean(["a", "c"])); // false
  * ```
  */
bool isAnyBoolean(Json[string] map, string[] keys) {
  return keys
    .filter!(key => map.hasKey(key))
    .map!(key => map[key])
    .array
    .isAnyBoolean;
}
/// 
unittest {
  // Test with keys where some are booleans
  Json[string] map = [
    "a": Json(1),
    "b": Json(true),
    "c": Json(false),
    "d": Json("string")
  ];
  string[] keys1 = ["b", "c"];
  assert(isAnyBoolean(map, keys1), "Should be true: keys 'b' and 'c' are booleans");

  // Test with keys where none are booleans
  string[] keys2 = ["a", "d"];
  assert(!isAnyBoolean(map, keys2), "Should be false: keys 'a' and 'd' are not booleans");

  // Test with keys where one is boolean, one is not
  string[] keys3 = ["a", "b"];
  assert(isAnyBoolean(map, keys3), "Should be true: key 'b' is boolean");

  // Test with keys that do not exist in the map
  string[] keys4 = ["x", "y"];
  assert(!isAnyBoolean(map, keys4), "Should be false: keys do not exist");

  // Test with mixed existing and non-existing keys
  string[] keys5 = ["b", "x"];
  assert(isAnyBoolean(map, keys5), "Should be true: key 'b' is boolean, 'x' does not exist");

  // Test with empty keys array
  string[] keys6 = [];
  assert(!isAnyBoolean(map, keys6), "Should be false: empty keys array");

  // Test with empty map and non-empty keys
  Json[string] emptyMap;
  string[] keys7 = ["a", "b"];
  assert(!isAnyBoolean(emptyMap, keys7), "Should be false: empty map");

  // Test with empty map and empty keys
  string[] keys8 = [];
  assert(!isAnyBoolean(emptyMap, keys8), "Should be false: empty map and empty keys");
}

/** 
  * Checks if the given JSON value is a boolean or contains any boolean values if it's an array or object.
  *
  * Params:
  *   json = The JSON value to check.
  *
  * Returns:
  *   `true` if the JSON value is a boolean or contains any boolean values, `false` otherwise.

  */
bool isAnyBoolean(Json json) {
  if (json.isArray) {
    return json.toArray.isAnyBoolean;
  }

  if (json.isObject) {
    return json.toMap.isAnyBoolean;
  }

  return json.isBoolean;
}
/// 
unittest {
  // Test isAnyBoolean(Json) with array containing booleans
  Json arrJson = Json.emptyArray;
  arrJson ~= true;
  arrJson ~= false;
  arrJson ~= 1;
  assert(isAnyBoolean(arrJson), "Should be true: array contains booleans");

  // Test isAnyBoolean(Json) with array containing no booleans
  Json arrJson2 = Json.emptyArray;
  arrJson2 ~= 1;
  arrJson2 ~= "string";
  arrJson2 ~= 2.5;
  assert(!isAnyBoolean(arrJson2), "Should be false: array contains no booleans");

  // Test isAnyBoolean(Json) with empty array
  Json arrJson3 = Json.emptyArray;
  assert(!isAnyBoolean(arrJson3), "Should be false: empty array");

  // Test isAnyBoolean(Json) with map containing booleans
  Json mapJson = Json.emptyObject;
  mapJson["a"] = Json(1);
  mapJson["b"] = Json(true);
  mapJson["c"] = Json("string");
  assert(isAnyBoolean(mapJson), "Should be true: map contains a boolean");

  // Test isAnyBoolean(Json) with map containing no booleans
  Json mapJson2 = Json.emptyObject;
  mapJson2["a"] = Json(1);
  mapJson2["b"] = Json("string");
  mapJson2["c"] = Json(2.5);
  assert(!isAnyBoolean(mapJson2), "Should be false: map contains no booleans");

  // Test isAnyBoolean(Json) with empty map
  Json mapJson3 = Json.emptyObject;
  assert(!isAnyBoolean(mapJson3), "Should be false: empty map");

  // Test isAnyBoolean(Json) with scalar boolean
  Json scalarBool = Json(true);
  assert(isAnyBoolean(scalarBool), "Should be true: scalar boolean is treated as array/map");

  // Test isAnyBoolean(Json) with scalar non-boolean
  Json scalarInt = Json(1);
  assert(!isAnyBoolean(scalarInt), "Should be false: scalar non-boolean");
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
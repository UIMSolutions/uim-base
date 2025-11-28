/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.algorithms.comparisons.isany;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

/** 
  * Checks if any element in the JSON structure satisfies the given condition.
  * 
  * Params:
  *   json = The JSON object or array to check
  *   func = A delegate function that takes either (string key, Json value), (string key), or (Json value)
  *          and returns a boolean indicating whether the condition is met
  * 
  * Returns:
  *   'true' if any element satisfies the condition, 'false' otherwise
  */
bool isAny(Json json, bool delegate(string key, Json value) @safe func) {
  if (!json.isObject) {
    return false;
  }

  return json.byKeyValue.any!(kv => func(kv.key, kv.value));
}
/// 
unittest { // isAny(Json, delegate(string, Json))
  // Test with object containing key-value pairs
  auto obj = Json.emptyObject;
  obj["apple"] = 1;
  obj["banana"] = 2;
  obj["cherry"] = 3;

  // Should find key-value pair where key length + value > 5
  assert(obj.isAny((string key, Json value) => key.length + value.get!int > 5));

  // Should find key-value pair where value equals 2
  assert(obj.isAny((string key, Json value) => value.get!int == 2));

  // Should find key-value pair where key starts with 'b'
  assert(obj.isAny((string key, Json value) => key[0] == 'b'));

  // Should not find key-value pair where value > 10
  assert(!obj.isAny((string key, Json value) => value.get!int > 10));

  // Should not find key-value pair where key equals "orange"
  assert(!obj.isAny((string key, Json value) => key == "orange"));

  // Test with empty object
  auto emptyObj = Json.emptyObject;
  assert(!emptyObj.isAny((string key, Json value) => true));
  assert(!emptyObj.isAny((string key, Json value) => false));

  // Test with non-object (array) - should return false
  auto arr = Json.emptyArray;
  arr ~= 1;
  arr ~= 2;
  assert(!arr.isAny((string key, Json value) => true));

  // Test with non-object (null) - should return false
  auto nullJson = Json(null);
  assert(!nullJson.isAny((string key, Json value) => true));

  // Test with single key-value pair
  auto singleObj = Json.emptyObject;
  singleObj["x"] = 42;
  assert(singleObj.isAny((string key, Json value) => key == "x" && value.get!int == 42));
  assert(!singleObj.isAny((string key, Json value) => key == "y" || value.get!int == 0));

  // Test with all pairs matching
  auto allMatch = Json.emptyObject;
  allMatch["a"] = 1;
  allMatch["b"] = 2;
  assert(allMatch.isAny((string key, Json value) => key.length == 1 && value.get!int > 0));

  // Test with no pairs matching
  assert(!allMatch.isAny((string key, Json value) => key.length > 5 && value.get!int < 0));
  // Test with complex condition
  auto complex1 = Json.emptyObject;
  complex1["short"] = 100;
  complex1["verylongkey"] = 1;
  assert(complex1.isAny((string key, Json value) => key.length > 10 && value.get!int < 10));
  assert(complex1.isAny((key, value) => key.length > 10 && value.get!int < 10));
}

/** 
  * Checks if any element in the JSON structure satisfies the given condition.
  * 
  * Params:
  *   json = The JSON object or array to check
  *   func = A delegate function that takes either (string key, Json value), (string key), or (Json value)
  *          and returns a boolean indicating whether the condition is met
  * 
  * Returns:
  *   'true' if any element satisfies the condition, 'false' otherwise
  */
bool isAny(Json json, bool delegate(string key) @safe func) {
  if (!json.isObject) {
    return false;
  }

  return json.byKeyValue.any!(kv => func(kv.key));
}
///
unittest {
  // Test with object containing keys
  auto obj = Json.emptyObject;
  obj["apple"] = 1;
  obj["banana"] = 2;
  obj["cherry"] = 3;

  // Should find key with length > 5
  assert(obj.isAny((string key) => key.length > 5));

  // Should find key starting with 'a'
  assert(obj.isAny((string key) => key[0] == 'a'));

  // Should not find key with length > 10
  assert(!obj.isAny((string key) => key.length > 10));

  // Should not find key starting with 'z'
  assert(!obj.isAny((string key) => key[0] == 'z'));

  // Test with empty object
  auto emptyObj = Json.emptyObject;
  assert(!emptyObj.isAny((string key) => true));
  assert(!emptyObj.isAny((string key) => false));

  // Test with non-object (array) - should return false
  auto arr = Json.emptyArray;
  arr ~= 1;
  arr ~= 2;
  assert(!arr.isAny((string key) => true));

  // Test with non-object (null) - should return false
  auto nullJson = Json(null);
  assert(!nullJson.isAny((string key) => true));

  // Test with single key object
  auto singleObj = Json.emptyObject;
  singleObj["x"] = 42;
  assert(singleObj.isAny((string key) => key == "x"));
  assert(!singleObj.isAny((string key) => key == "y"));

  // Test with all keys matching
  auto allMatch = Json.emptyObject;
  allMatch["a"] = 1;
  allMatch["b"] = 2;
  assert(allMatch.isAny((string key) => key.length == 1));
  assert(allMatch.isAny(key => key.length == 1));

  // Test with no keys matching
  assert(!allMatch.isAny((string key) => key.length > 5));
  assert(!allMatch.isAny(key => key.length > 5));
}

/**
  * Checks if any element in the JSON structure satisfies the given condition.
  * 
  * Params:
  *   json = The JSON object or array to check
  *   func = A delegate function that takes either (string key, Json value), (string key), or (Json value)
  *          and returns a boolean indicating whether the condition is met
  * 
  * Returns:
  *   'true' if any element satisfies the condition, 'false' otherwise
  */
bool isAny(Json json, bool delegate(Json value) @safe func) {
  if (!json.isObject && !json.isArray) {
    return false;
  }

  return json.byValue.any!(value => func(value));
}
///
// Test isAny with delegate(Json value) on objects
unittest {
  auto obj1 = Json.emptyObject;
  obj1["a"] = 1;
  obj1["b"] = 2;
  obj1["c"] = 3;

  // Should find value equal to 2
  assert(obj1.isAny((Json value) => value.get!int == 2));

  // Should find value greater than 2
  assert(obj1.isAny((Json value) => value.get!int > 2));

  // Should find value less than 2
  assert(obj1.isAny((Json value) => value.get!int < 2));

  // Should not find value greater than 10
  assert(!obj1.isAny((Json value) => value.get!int > 10));

  // Should not find value equal to 0
  assert(!obj1.isAny((Json value) => value.get!int == 0));

  // Test isAny with delegate(Json value) on arrays
  auto arr = Json.emptyArray;
  arr ~= 1;
  arr ~= 2;
  arr ~= 3;

  // Should find value equal to 2
  assert(arr.isAny((Json value) => value.get!int == 2));

  // Should find value greater than 2
  assert(arr.isAny((Json value) => value.get!int > 2));

  // Should find value less than 3
  assert(arr.isAny((Json value) => value.get!int < 3));

  // Should not find value greater than 5
  assert(!arr.isAny((Json value) => value.get!int > 5));

  // Should not find negative value
  assert(!arr.isAny((Json value) => value.get!int < 0));

  // Test isAny with empty collections
  auto emptyObj = Json.emptyObject;
  assert(!emptyObj.isAny((Json value) => true));
  assert(!emptyObj.isAny((Json value) => false));

  auto emptyArr = Json.emptyArray;
  assert(!emptyArr.isAny((Json value) => true));
  assert(!emptyArr.isAny((Json value) => false));

  // Test isAny with non-object and non-array types
  auto nullJson = Json(null);
  assert(!nullJson.isAny((Json value) => true));

  auto intJson = Json(42);
  assert(!intJson.isAny((Json value) => true));

  auto stringJson = Json("test");
  assert(!stringJson.isAny((Json value) => true));

  auto boolJson = Json(true);
  assert(!boolJson.isAny((Json value) => true));

  // Test isAny with single element collections
  auto singleObj = Json.emptyObject;
  singleObj["x"] = 42;
  assert(singleObj.isAny((Json value) => value.get!int == 42));
  assert(!singleObj.isAny((Json value) => value.get!int == 0));

  auto singleArr = Json.emptyArray;
  singleArr ~= 42;
  assert(singleArr.isAny((Json value) => value.get!int == 42));
  assert(!singleArr.isAny((Json value) => value.get!int == 0));

  // Test isAny with all elements matching
  auto allMatchObj = Json.emptyObject;
  allMatchObj["a"] = 1;
  allMatchObj["b"] = 2;
  allMatchObj["c"] = 3;
  assert(allMatchObj.isAny((Json value) => value.get!int > 0));

  auto allMatchArr = Json.emptyArray;
  allMatchArr ~= 1;
  allMatchArr ~= 2;
  allMatchArr ~= 3;
  assert(allMatchArr.isAny((Json value) => value.get!int > 0));

  // Test isAny with no elements matching
  auto noMatchObj = Json.emptyObject;
  noMatchObj["a"] = 1;
  noMatchObj["b"] = 2;
  assert(!noMatchObj.isAny((Json value) => value.get!int > 10));

  auto noMatchArr = Json.emptyArray;
  noMatchArr ~= 1;
  noMatchArr ~= 2;
  assert(!noMatchArr.isAny((Json value) => value.get!int > 10));

  // Test isAny with mixed types in array
  auto mixedArr = Json.emptyArray;
  mixedArr ~= 1;
  mixedArr ~= "string";
  mixedArr ~= true;

  assert(mixedArr.isAny((Json value) => value.type == Json.Type.int_));
  assert(mixedArr.isAny((Json value) => value.type == Json.Type.string));
  assert(mixedArr.isAny((Json value) => value.type == Json.Type.bool_));
  assert(!mixedArr.isAny((Json value) => value.type == Json.Type.null_));

  // Test isAny with nested structures
  auto nested = Json.emptyArray;
  auto innerObj = Json.emptyObject;
  innerObj["x"] = 5;
  nested ~= innerObj;
  nested ~= 10;

  assert(nested.isAny((Json value) => value.isObject));
  assert(nested.isAny(value => value.isObject));

  assert(nested.isAny((Json value) => value.type == Json.Type.int_));
  assert(nested.isAny(value => value.type == Json.Type.int_));
}

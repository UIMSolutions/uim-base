/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.algorithms.comparisons.isall;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

/**
  * Checks if all key-value pairs in the Json object satisfy the given condition.
  *
  * Params:
  *   json = The Json object to check
  *   func = A delegate that takes a key and value, returning true if the condition is met
  * Returns:
  *   'true' if all key-value pairs satisfy the condition, 'false' otherwise
  */
bool isAll(Json json, bool delegate(string key, Json value) @safe func) {
  if (!json.isObject) {
    return false;
  }

  return json.byKeyValue.all!(kv => func(kv.key, kv.value));
}
///
unittest {
  // Test: isAll with key-value predicate - all key-value pairs satisfy condition
  Json obj = Json.emptyObject;
  obj["one"] = 1;
  obj["two"] = 2;
  obj["three"] = 3;
  assert(isAll(obj, (string key, Json value) => value.isInteger && value.get!int > 0));

  // Test: isAll with key-value predicate - not all values satisfy condition
  Json obj2 = Json.emptyObject;
  obj2["a"] = 1;
  obj2["b"] = -2;
  obj2["c"] = 3;
  assert(!isAll(obj2, (string key, Json value) => value.isInteger && value.get!int > 0));

  // Test: isAll with key-value predicate - key matches value string length
  Json obj3 = Json.emptyObject;
  obj3["hi"] = "ok";
  obj3["bye"] = "yes";
  assert(isAll(obj3, (string key, Json value) => value.isString && key.length <= value
      .get!string.length));

  // Test: isAll with key-value predicate - empty object returns true
  Json emptyObj = Json.emptyObject;
  assert(isAll(emptyObj, (string key, Json value) => false));

  // Test: isAll with key-value predicate - non-object returns false
  Json arr = Json([1, 2, 3]);
  assert(!isAll(arr, (string key, Json value) => true));

  // Test: isAll with key-value predicate - single key-value object
  Json singleObj = Json.emptyObject;
  singleObj["x"] = 42;
  assert(isAll(singleObj, (string key, Json value) => key == "x" && value.get!int == 42));
  assert(!isAll(singleObj, (string key, Json value) => key == "y"));

  // Test: isAll with key-value predicate - mixed value types
  Json mixedObj = Json.emptyObject;
  mixedObj["a"] = 1;
  mixedObj["b"] = "str";
  mixedObj["c"] = true;
  assert(!isAll(mixedObj, (string key, Json value) => value.isInteger));
}

/**
  * Checks if all keys in the Json object satisfy the given condition.
  *
  * Params:
  *   json = The Json object to check
  *   func = A delegate that takes a key, returning true if the condition is met
  * Returns:
  *   'true' if all keys satisfy the condition, 'false' otherwise
  */
bool isAll(Json json, bool delegate(string key) @safe func) {
  if (!json.isObject) {
    return false;
  }

  return json.byKeyValue.all!(kv => func(kv.key));
}
///
unittest {
  // Test: isAll with key predicate - all keys satisfy condition
  Json obj = Json.emptyObject;
  obj["abc"] = 1;
  obj["def"] = 2;
  obj["ghi"] = 3;
  assert(isAll(obj, (string key) => key.length == 3));

  // Test: isAll with key predicate - not all keys satisfy condition
  Json obj2 = Json.emptyObject;
  obj2["a"] = 1;
  obj2["bc"] = 2;
  obj2["def"] = 3;
  assert(!isAll(obj2, (string key) => key.length == 3));

  // Test: isAll with key predicate - all keys start with specific letter
  Json obj3 = Json.emptyObject;
  obj3["apple"] = 1;
  obj3["avocado"] = 2;
  obj3["apricot"] = 3;
  assert(isAll(obj3, (string key) => key[0] == 'a'));

  // Test: isAll with key predicate - empty object returns true
  Json emptyObj = Json.emptyObject;
  assert(isAll(emptyObj, (string key) => false));

  // Test: isAll with key predicate - non-object returns false
  Json arr1 = Json([1, 2, 3]);
  assert(!isAll(arr1, (string key) => true));

  // Test: isAll with key predicate - single key object
  Json singleKey = Json.emptyObject;
  singleKey["x"] = 42;
  assert(isAll(singleKey, (string key) => key == "x"));
  assert(!isAll(singleKey, (string key) => key == "y"));

  // Test: isAll with key-value predicate - all pairs satisfy condition
  Json obj4 = Json.emptyObject;
  obj4["a"] = 1;
  obj4["b"] = 2;
  obj4["c"] = 3;
  assert(isAll(obj4, (string key, Json value) => value.get!int > 0));

  // Test: isAll with key-value predicate - key length matches value
  Json obj5 = Json.emptyObject;
  obj5["a"] = 1;
  obj5["bb"] = 2;
  obj5["ccc"] = 3;
  assert(isAll(obj5, (string key, Json value) => key.length == value.get!int));

  // Test: isAll with key-value predicate - not all pairs satisfy
  Json obj6 = Json.emptyObject;
  obj6["a"] = 1;
  obj6["b"] = 2;
  obj6["c"] = -3;
  assert(!isAll(obj6, (string key, Json value) => value.get!int > 0));

  // Test: isAll with key-value predicate - non-object returns false
  Json val = Json(42);
  assert(!isAll(val, (string key, Json value) => true));

  // Test: isAll with value predicate on objects
  Json obj7 = Json.emptyObject;
  obj7["x"] = 10;
  obj7["y"] = 20;
  obj7["z"] = 30;
  assert(isAll(obj7, (Json v) => v.get!int >= 10));
  assert(!isAll(obj7, (Json v) => v.get!int > 20));

  // Test: isAll with value predicate on arrays
  Json arr2 = Json.emptyArray;
  arr2 ~= 5;
  arr2 ~= 10;
  arr2 ~= 15;
  assert(isAll(arr2, (Json v) => v.get!int % 5 == 0));
  assert(!isAll(arr2, (Json v) => v.get!int > 10));

  // Test: isAll with value predicate - mixed types in array
  Json mixedArr = Json.emptyArray;
  mixedArr ~= 1;
  mixedArr ~= "text";
  mixedArr ~= 3;
  assert(!isAll(mixedArr, (Json v) => v.isInteger));

  // Test: isAll with value predicate - string values
  Json strObj = Json.emptyObject;
  strObj["a"] = "hello";
  strObj["b"] = "world";
  assert(isAll(strObj, (Json v) => v.isString));
}

/**
  * Checks if all values in the Json object or array satisfy the given condition.
  *
  * Params:
  *   json = The Json object or array to check
  *   func = A delegate that takes a value, returning true if the condition is met
  * Returns:
  *   'true' if all values satisfy the condition, 'false' otherwise
  */
bool isAll(Json json, bool delegate(Json value) @safe func) {
  if (!json.isObject && !json.isArray) {
    return false;
  }
  if (json.isNull || json.isEmpty) {
    return false;
  }

  return json.byValue.all!(value => func(value));
}
///
unittest {
  // Test: isAll on object, all values satisfy condition
  Json obj = Json.emptyObject;
  obj["a"] = 1;
  obj["b"] = 2;
  obj["c"] = 3;
  assert(isAll(obj, (Json v) => v.isInteger && v.get!int > 0));

  // Test: isAll on object, not all values satisfy condition
  Json obj2 = Json.emptyObject;
  obj2["a"] = 1;
  obj2["b"] = -2;
  obj2["c"] = 3;
  assert(!isAll(obj2, (Json v) => v.isInteger && v.get!int > 0));

  // Test: isAll on array, all values satisfy condition
  Json arr1 = Json([1, 2, 3]);
  assert(isAll(arr1, (Json v) => v.isInteger));

  // Test: isAll on array, not all values satisfy condition
  Json arr2 = Json.emptyArray;
  arr2 ~= 1;
  arr2 ~= "x";
  arr2 ~= 3;
  assert(!isAll(arr2, (Json v) => v.isInteger));

  // Test: isAll on non-object/non-array (should return false)
  Json val = Json(42);
  assert(!isAll(val, (Json v) => true));

  // Test: isAll on empty object (should return true)
  Json emptyObj = Json.emptyObject; // empty object
  assert(isAll(emptyObj, (Json v) => false));

  // Test: isAll on empty array (should return true)
  Json emptyArr = Json.emptyArray;
  assert(isAll(emptyArr, (Json v) => false));
}

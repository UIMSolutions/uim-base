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
  Json obj = Json(["one": 1, "two": 2, "three": 3]);
  assert(isAll(obj, (string key, Json value) => value.isInteger && value.get!int > 0));

  // Test: isAll with key-value predicate - not all values satisfy condition
  Json obj2 = Json(["a": 1, "b": -2, "c": 3]);
  assert(!isAll(obj2, (string key, Json value) => value.isInteger && value.get!int > 0));

  // Test: isAll with key-value predicate - key matches value string length
  Json obj3 = Json(["hi": "ok", "bye": "yes"]);
  assert(isAll(obj3, (string key, Json value) => value.isString && key.length <= value
      .get!string.length));

  // Test: isAll with key-value predicate - empty object returns true
  Json emptyObj = Json.emptyObject;
  assert(isAll(emptyObj, (string key, Json value) => false));

  // Test: isAll with key-value predicate - non-object returns false
  Json arr = Json([1, 2, 3]);
  assert(!isAll(arr, (string key, Json value) => true));

  // Test: isAll with key-value predicate - single key-value object
  Json singleObj = Json(["x": 42]);
  assert(isAll(singleObj, (string key, Json value) => key == "x" && value.get!int == 42));
  assert(!isAll(singleObj, (string key, Json value) => key == "y"));

  // Test: isAll with key-value predicate - mixed value types
  Json mixedObj = Json(["a": 1, "b": "str", "c": true]);
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
  Json obj = Json(["abc": 1, "def": 2, "ghi": 3]);
  assert(isAll(obj, (string key) => key.length == 3));

  // Test: isAll with key predicate - not all keys satisfy condition
  Json obj2 = Json(["a": 1, "bc": 2, "def": 3]);
  assert(!isAll(obj2, (string key) => key.length == 3));

  // Test: isAll with key predicate - all keys start with specific letter
  Json obj3 = Json(["apple": 1, "avocado": 2, "apricot": 3]);
  assert(isAll(obj3, (string key) => key[0] == 'a'));

  // Test: isAll with key predicate - empty object returns true
  Json emptyObj = Json.emptyObject;
  assert(isAll(emptyObj, (string key) => false));

  // Test: isAll with key predicate - non-object returns false
  Json arr = Json([1, 2, 3]);
  assert(!isAll(arr, (string key) => true));

  // Test: isAll with key predicate - single key object
  Json singleKey = Json(["x": 42]);
  assert(isAll(singleKey, (string key) => key == "x"));
  assert(!isAll(singleKey, (string key) => key == "y"));

  // Test: isAll with key-value predicate - all pairs satisfy condition
  Json obj4 = Json(["a": 1, "b": 2, "c": 3]);
  assert(isAll(obj4, (string key, Json value) => value.get!int > 0));

  // Test: isAll with key-value predicate - key length matches value
  Json obj5 = Json(["a": 1, "bb": 2, "ccc": 3]);
  assert(isAll(obj5, (string key, Json value) => key.length == value.get!int));

  // Test: isAll with key-value predicate - not all pairs satisfy
  Json obj6 = Json(["a": 1, "b": 2, "c": -3]);
  assert(!isAll(obj6, (string key, Json value) => value.get!int > 0));

  // Test: isAll with key-value predicate - non-object returns false
  Json val = Json(42);
  assert(!isAll(val, (string key, Json value) => true));

  // Test: isAll with value predicate on objects
  Json obj7 = Json(["x": 10, "y": 20, "z": 30]);
  assert(isAll(obj7, (Json v) => v.get!int >= 10));
  assert(!isAll(obj7, (Json v) => v.get!int > 20));

  // Test: isAll with value predicate on arrays
  Json arr = Json([5, 10, 15]);
  assert(isAll(arr, (Json v) => v.get!int % 5 == 0));
  assert(!isAll(arr, (Json v) => v.get!int > 10));

  // Test: isAll with value predicate - mixed types in array
  Json mixedArr = Json([1, "text", 3]);
  assert(!isAll(mixedArr, (Json v) => v.isInteger));

  // Test: isAll with value predicate - string values
  Json strObj = Json(["a": "hello", "b": "world"]);
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

  return json.byValue.all!(value => func(value));
}
///
unittest {
  // Test: isAll on object, all values satisfy condition
  Json obj = Json(["a": 1, "b": 2, "c": 3]);
  assert(isAll(obj, (Json v) => v.isInteger && v.get!int > 0));
  assert(isAll(obj, v => v.isInteger && v.get!int > 0));

  // Test: isAll on object, not all values satisfy condition
  Json obj2 = Json(["a": 1, "b": -2, "c": 3]);
  assert(!isAll(obj2, (Json v) => v.isInteger && v.get!int > 0));
  assert(!isAll(obj2, v => v.isInteger && v.get!int > 0));

  // Test: isAll on array, all values satisfy condition
  Json arr = Json([1, 2, 3]);
  assert(isAll(arr, (Json v) => v.isInteger));
  assert(isAll(arr, v => v.isInteger));

  // Test: isAll on array, not all values satisfy condition
  Json arr2 = Json([1, "x", 3]);
  assert(!isAll(arr2, (Json v) => v.isInteger));
  assert(!isAll(arr2, v => v.isInteger));

  // Test: isAll on non-object/non-array (should return false)
  Json val = Json(42);
  assert(!isAll(val, (Json v) => true));
  assert(!isAll(val, v => true));

  // Test: isAll on empty object (should return true)
  Json emptyObj = Json([]); // empty object
  assert(isAll(emptyObj, (Json v) => false));
  assert(isAll(emptyObj, v => false));

  // Test: isAll on empty array (should return true)
  Json emptyArr = Json([]);
  assert(isAll(emptyArr, (Json v) => false));
  assert(isAll(emptyArr, v => false));
}

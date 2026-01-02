/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
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

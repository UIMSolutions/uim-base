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

  return json.byValue.all!(value => func(value));
}

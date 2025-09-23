/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.datatypes.json.keys;

mixin(Version!("test_uim_vibe"));

import uim.vibe;

@safe:

// #region keys
// Get keys from json object
string[] keys(Json json, bool sorted = false) {
  return json.isObject
    ? json.convert((string key) => key) : null;
}

unittest {
  auto json = parseJsonString(`{"a": "b", "c": {"d": 1}, "e": ["f", {"g": "h"}]}`);
  assert(json.keys.hasAllValues(["a", "c", "e"]));
  assert(!json.keys.hasAllValues(["a", "c", "x"]));
}
// #endregion keys

// #region hasSearch
// #region Json[string]
bool hasAll(Json[string] items, string[] keys) {
  return keys.all!(key => has(items, key));
}

bool hasAny(Json[string] items, string[] keys) {
  return keys.any!(key => has(items, key));
}

bool has(Json[string] items, string key) {
  return key in items ? true : false;
}
// #endregion Json[string]

// #region Json[]
bool hasAll(Json[] items, string[] keys) {
  return keys.all!(key => has(items, key));
}

bool hasAny(Json[] items, string[] keys) {
  return keys.any!(key => has(items, key));
}

bool hasKey(Json[] items, string key) {
  return items.any!(item => item.hasKey(key));
}
// #endregion Json[]

// #region Json
// Check if json has key
bool hasAll(Json json, string[] keys) {
  return keys.all!(key => hasKey(json, key));
}

/// Check if Json has key
bool hasAny(Json json, string[] keys) {
  return keys.any!(key => hasKey(json, key));
}

/// Searching key in json, if depth = true also in subnodes  
bool hasKey(Json json, string key) {
  if (!json.isObject)
    return false;

  foreach (kv; json.byKeyValue) {
    if (kv.key == key) {
      return true;
    }
/*     if (deepSearch) {
      if (kv.value.has(key))
        return true;
    }
 */  }

  return false;
}

unittest {
  auto json = parseJsonString(`{"a": "b", "c": {"d": 1}, "e": ["f", {"g": "h"}]}`);
  assert(json.has("a"));
  assert(!json.has("x"));

  assert(json.hasAny(["y", "c"]));
  assert(!json.hasAny(["x", "y"]));

  assert(json.hasAll(["a", "c"]));
  assert(!json.hasAll(["x", "c"]));
}
// #endregion Json
// #endregion hasSearch

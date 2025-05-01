/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.data.json.keys;

mixin(Version!("test_uim_vibe"));

import uim.vibe;

@safe:

// #region keys
// Get keys from json object
string[] keys(Json json) {
  return json.isObject
    ? json.byKeyValue.map!(kv => kv.key).array : null;
}

unittest {
  auto json = parseJsonString(`{"a": "b", "c": {"d": 1}, "e": ["f", {"g": "h"}]}`);
  assert(json.keys.hasAllValues("a", "c", "e"));
  assert(!json.keys.hasAllValues("a", "c", "x"));
}
// #endregion keys

// #region hasKeySearch
// #region Json[string]
bool hasAllKeys(Json[string] items, string[] keys, bool deepSearch) {
  return keys.all!(key => hasKey(items, key, deepSearch));
}

bool hasAnyKeys(Json[string] items, string[] keys, bool deepSearch) {
  return keys.any!(key => hasKey(items, key, deepSearch));
}

bool hasKey(Json[string] items, string key, bool deepSearch) {
  if (items.length == 0)
    return false;

  return key in items
    ? true : hasKey(items.getValues, key, deepSearch);
}
// #endregion Json[string]

// #region Json[]
bool hasAllKeys(Json[] items, string[] keys, bool deepSearch) {
  return keys.all!(key => hasKey(items, key, deepSearch));
}

bool hasAnyKeys(Json[] items, string[] keys, bool deepSearch) {
  return keys.any!(key => hasKey(items, key, deepSearch));
}

bool hasKey(Json[] items, string key, bool deepSearch) {
  return items.any!(item => item.hasKey(key, deepSearch));
}
// #endregion Json[]

// #region Json
// Check if json has key
bool hasAllKeys(Json json, string[] keys, bool deepSearch) {
  return keys.all!(key => hasKey(json, key, deepSearch));
}

/// Check if Json has key
bool hasAnyKeys(Json json, string[] keys, bool deepSearch) {
  return keys.any!(key => hasKey(json, key, deepSearch));
}

/// Searching key in json, if depth = true also in subnodes  
bool hasKey(Json json, string key, bool deepSearch) {
  if (!json.isObject)
    return false;

  foreach (kv; json.byKeyValue) {
    if (kv.key == key) {
      return true;
    }
    if (deepSearch) {
      if (kv.value.hasKey(key, false))
        return true;
    }
  }

  return false;
}

unittest {
  auto json = parseJsonString(`{"a": "b", "c": {"d": 1}, "e": ["f", {"g": "h"}]}`);
  assert(json.hasKey("a"));
  assert(json.hasKey("d"));
  assert(!json.hasKey("x"));
  assert(json.hasAnyKeys(["y", "c"]));
  assert(json.hasAnyKeys(["y", "d"]));
  assert(json.hasAnyKeys("y", "c"));
  assert(!json.hasAnyKeys("x", "y"));
  assert(json.hasAllKeys(["a", "c"]));
  assert(json.hasAllKeys(["a", "d"]));
  assert(json.hasAllKeys("a", "c"));
  assert(!json.hasAllKeys("x", "c"));
}
// #endregion Json
// #endregion hasKeySearch

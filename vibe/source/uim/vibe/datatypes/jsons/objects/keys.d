module uim.vibe.datatypes.jsons.objects.keys;

import uim.vibe;

mixin(Version!("test_uim_vibe"));
@safe:

// #region keys
// Get keys from json object
string[] keys(Json json, bool sorted = false) {
  return json.isObject
    ? json.convert((string key) => key) : null;
}

unittest {
  auto json = parseJsonString(`{"a": "b", "c": {"d": 1}, "e": ["f", {"g": "h"}]}`);
  assert(json.keys.hasAll(["a", "c", "e"]));
  assert(!json.keys.hasAll(["a", "c", "x"]));
}
// #endregion keys

// #region hasSearch
// #region Json[string]
bool hasAllKey(Json[string] items, string[] keys) {
  return keys.all!(key => hasKey(items, key));
}

bool hasAnyKey(Json[string] items, string[] keys) {
  return keys.any!(key => hasKey(items, key));
}

bool hasKey(Json[string] items, string key) {
  return key in items ? true : false;
}
// #endregion Json[string]

// #region Json[]
bool hasAllKey(Json[] items, string[] keys) {
  return keys.all!(key => hasKey(items, key));
}

bool hasAnyKey(Json[] items, string[] keys) {
  return keys.any!(key => hasKey(items, key));
}

bool hasKey(Json[] items, string key) {
  return items.any!(item => item.hasKey(key));
}
// #endregion Json[]

// #region Json
// Check if json has key
bool hasAllKey(Json json, string[] keys) {
  return keys.all!(key => hasKey(json, key));
}

/// Check if Json has key
bool hasAnyKey(Json json, string[] keys) {
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
      if (kv.value.hasKey(key))
        return true;
    }
 */  }

  return false;
}

unittest {
  auto json = parseJsonString(`{"a": "b", "c": {"d": 1}, "e": ["f", {"g": "h"}]}`);
  assert(json.hasKey("a"));
  assert(!json.hasKey("x"));

  assert(json.hasAnyKey(["y", "c"]));
  assert(!json.hasAnyKey(["x", "y"]));

  assert(json.hasAllKey(["a", "c"]));
  assert(!json.hasAllKey(["x", "c"]));
}
// #endregion Json
// #endregion hasSearch

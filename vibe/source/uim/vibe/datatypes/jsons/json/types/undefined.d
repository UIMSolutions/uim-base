/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.json.types.undefined;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region path
// #region all
bool isAllUndefined(Json json, string[][] paths) {
  return paths.all!(path => json.isUndefined(path));
}
// #endregion all

// #region any
bool isAnyUndefined(Json json, string[][] paths) {
  return paths.any!(path => json.isUndefined(path));
}
// #endregion any

// #region is
bool isUndefined(Json json, string[] path) {
  if (json.isUndefined || path.length == 0) {
    return true;
  }

  auto firstKey = path[0];
  if (json.isUndefined(firstKey)) {
    return true;
  }

  return path.length > 1 && json[firstKey].isUndefined(path[1 .. $]);
}
// #endregion is
// #endregion path

// #region key
// #region all
bool isAllUndefined(Json json, string[] keys) {
  return keys.all!(key => json.isUndefined(key));
}
// #endregion all

// #region any
bool isAnyUndefined(Json json, string[] keys) {
  return keys.any!(key => json.isUndefined(key));
}
// #endregion any

// #region is
bool isUndefined(Json json, string key) {
  return json.isObject && key in json && json[key].isUndefined;
}
// #endregion is
// #endregion key

// #region scalar
/** 
  * Checks if the given JSON value is undefined.
  *
  * Params:
  *   json = The JSON value to check.
  *
  * Returns:
  *   `true` if the JSON value is undefined, `false` otherwise.
  */
bool isUndefined(Json json) {
  return json.type == Json.Type.undefined; 
}
/// 
unittest {
  assert(Json(undefined).isUndefined);
  assert(!Json.emptyObject.isUndefined);
  assert(!Json.emptyArray.isUndefined);

  auto json = parseJsonString(`{"a": "b", "c": {"d": 1}, "e": ["f", {"g": "h"}]}`);
  assert(json.isUndefined("x"));
  assert(!json.isUndefined("a"));

  assert(json.isUndefined(["x"]));
  assert(!json.isUndefined(["a"]));

  assert(json.isAllUndefined(["x", "y"]));
  assert(!json.isAllUndefined(["a", "y"]));
  assert(json.isAnyUndefined(["x", "y"]));
  assert(!json.isAnyUndefined(["a", "c"]));
}
// #endregion scalar
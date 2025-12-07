/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.json.types.null_;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region path
// #region all
bool isAllNull(Json json, string[][] paths) {
  return paths.all!(path => json.isNull(path));
}
// #endregion all

// #region any
bool isAnyNull(Json json, string[][] paths) {
  return paths.any!(path => json.isNull(path));
}
// #endregion any

// #region is
bool isNull(Json json, string[] path) {
  if (json.isNull || path.length == 0) {
    return true;
  }

  auto firstKey = path[0];
  if (json.isNull(firstKey)) {
    return true;
  }

  return path.length > 1 && json[firstKey].isNull(path[1 .. $]);
}
// #endregion is
// #endregion path

// #region key
// #region all
bool isAllNull(Json json, string[] keys) {
  return keys.all!(key => json.isNull(key));
}
// #endregion all

// #region any
bool isAnyNull(Json json, string[] keys) {
  return keys.any!(key => json.isNull(key));
}
// #endregion any

// #region is
bool isNull(Json json, string key) {
  if (json.isNull) {
    return true;
  }

  return json.isObject && key in json ? json[key].isNull : true;
}
// #endregion is
// #endregion key

// #region scalar
/** 
  * Checks if the given JSON value is null.
  *
  * Params:
  *   json = The JSON value to check.
  *
  * Returns:
  *   `true` if the JSON value is null, `false` otherwise.
  */
bool isNull(Json json) {
  return json == Json(null); 
}
/// 
unittest {
  assert(Json(null).isNull);
  assert(!Json.emptyObject.isNull);
  assert(!Json.emptyArray.isNull);

  auto json = parseJsonString(`{"a": "b", "c": {"d": 1}, "e": ["f", {"g": "h"}]}`);
  assert(json.isNull("x"));
  assert(!json.isNull("a"));

  assert(json.isNull(["x"]));
  assert(!json.isNull(["a"]));

  assert(json.isAllNull(["x", "y"]));
  assert(!json.isAllNull(["a", "y"]));
  assert(json.isAnyNull(["x", "y"]));
  assert(!json.isAnyNull(["a", "c"]));
}
// #endregion scalar
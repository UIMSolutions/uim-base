/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.data.json.string_;

mixin(Version!("test_uim_vibe"));

import uim.vibe;
@safe:

// #region is
mixin(CheckJsonIs!("String"));

bool isString(Json value, string[] path) {
  if (path.length == 0) {
    return false;
  }

  if (path.length == 1) {
    return value.isString(path[0]);
  }

  return path.length > 1 && value.hasKey(path[0]) 
    ? value[path[0]].isString(path[1..$]) : false;
}

bool isString(Json value, string key) {
  return value.hasKey(key)
    ? value[key].isString : false;
}

bool isString(Json value) {
  return (value.type == Json.Type.string);
}
unittest {
  assert(Json("text").isString);
  assert(!Json(10).isString);
  assert(!Json(1.1).isString);
  assert(!Json.emptyObject.isString);
  assert(!Json.emptyArray.isString);
  assert(!Json.nullValue.isString);

  auto json = parseJsonString(`{"a": "b", "c": {"d": 1}, "e": ["f", {"g": "h"}]}`);
  assert(json.isString("a"));
  assert(!json.isString("x"));

  assert(json.allString(["c", "x"]));
  assert(!json.allString(["c", "d"]));

  assert(json.String(["c", "d", "x"]));
  assert(!json.isString(["c", "d", "e"]));
  assert(json.isString(["c", "d", "a"]));
}
// #endregion is

// #region get
string getString(Json value, string key) {
  return value.isObject && value.hasKey(key)
    ? value[key].getString : null;
}

string getString(Json value) {
  return value.isString
    ? value.get!string : null;
}
// #endregion get

// #region only
// #endregion only

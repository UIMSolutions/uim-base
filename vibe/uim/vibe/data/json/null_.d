/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.data.json.null_;

mixin(Version!("test_uim_vibe"));

import uim.vibe;
@safe:

// #region is
// Check if json value is null
mixin(CheckJsonIs!("Null"));

bool isNull(Json value) {
  return (value.type == Json.Type.null_);
}

bool isNull(Json value, string[] path) {
  if (value.isNull) {
    return true;
  }

  if (path.length == 0) {
    return false;
  }

  auto firstKey = path[0];
  if (value.isNull(firstKey)) {
    return true;
  }

  return path.length > 1
    ? isNull(value[firstKey], path[1..$]) 
    : false;
}

bool isNull(Json value, string key) {
  return value.isObject && value.hasKey(key) 
    ? value[key].isNull
    : true;
}

unittest {
  assert(Json(null).isNull);
  assert(!Json.emptyObject.isNull);
  assert(!Json.emptyArray.isNull);

  auto json = parseJsonString(`{"a": "b", "c": {"d": 1}, "e": ["f", {"g": "h"}]}`);
  assert(json.isNull("x"));
  assert(!json.isNull("a"));

  assert(json.isNull(["x"]));
  assert(!json.isNull(["a"]));
  assert(json.isNull(["c", "x"]));
  assert(!json.isNull(["c", "d"]));
  assert(json.isNull(["c", "d", "x"]));

  assert(json.allNull(["x", "y"]));
  assert(!json.allNull(["a", "y"]));
  assert(json.anyNull(["x", "y"]));
  assert(!json.anyNull(["a", "c"]));
}
// #endregion is
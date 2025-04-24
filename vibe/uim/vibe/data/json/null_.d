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

bool isNull(Json[string] items, string key, bool strict = true) {
  return key in items && items[key].isNull(strict); 
}

bool isNull(Json json, string[] path) {
  if (json.isNull) {
    return true;
  }

  if (path.length == 0) {
    return false;
  }

  auto firstKey = path[0];
  if (json.isNull(firstKey)) {
    return true;
  }

  return path.length > 1
    ? isNull(json[firstKey], path[1..$]) 
    : false;
}

bool isNull(Json json, string key, bool strict = true) {
  return json.isObject && json.hasKey(key) 
    ? json[key].isNull(strict)
    : true;
}

bool isNull(Json value, bool strict = true) {
  if (!strict) {
    if (value.isString) {
      auto val = value.getString.toLower;
      return (val == "null") || (val == "none") || (val == "nil") ||
        (val == "undefined") || (val == "empty") || (val == "void");
    }
    if (value.isInteger) {
      return value.get!int == 0;
    }
    if (value.isDouble) {
      return value.get!double == 0.0;
    }
  }

  return value == Json(null); // null value
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
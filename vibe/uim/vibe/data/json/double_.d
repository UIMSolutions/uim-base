/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.data.json.double_;

mixin(Version!("test_uim_vibe"));

import uim.vibe;
@safe:

// #region is
mixin(CheckJsonIs!("Double"));

bool isDouble(Json value, bool strict = true) {
  if (!strict) {
    // check for boolean, integer, and string types
  }
  return (value.type == Json.Type.float_);
}

unittest { // Json
  assert(!Json(true).isDouble);  
  assert(!Json(10).isDouble);  
  assert(Json(1.1).isDouble);  
  assert(!Json("text").isDouble);
}

unittest { // Json[]
  auto a = Json(1.1);
  auto b = Json(2.1);
  auto c = Json(1);
  auto d = Json("1.1");
  auto list = [a, b, c, d];
  assert([a, b].isAllDouble);
  assert(![a, c].isAllDouble);

  assert(list.isAllDouble([0, 1]));
  assert(!list.isAllDouble([2, 3]));

  assert([a, b].isAnyDouble);
  assert([a, c].isAnyDouble);
  assert(![c, d].isAnyDouble);

  assert(list.isAnyDouble([0, 1]));
  assert(list.isAnyDouble([1, 2]));
  assert(!list.isAnyDouble([2, 3]));
}

unittest { // Json[string]
  auto a = Json(1.1);
  auto b = Json(2.1);
  auto c = Json(1);
  auto d = Json("1.1");
  auto map = ["A": a, "B": b, "C": c, "D": d];
  assert(["A": a, "B": b].isAllDouble);
  assert(!["A": a, "C": c].isAllDouble);

  assert(map.isAllDouble(["A", "B"]));
  assert(map.isAllDouble(["A", "C"]));

  assert(["A": a, "B": b].isAnyDouble);
  assert(["A": a, "C": c].isAnyDouble);
  assert(!["C": c, "D": d].isAnyDouble);

  assert(map.isAnyDouble(["A", "B"]));
  assert(map.isAnyDouble(["A", "C"]));
  assert(map.isAnyDouble(["C", "D"]));
}
// #endregion is

// #region get
double getDouble(Json value, string key, bool strict = true) {
  return !value.isNull && value.isObject && value.hasKey(key)
    ? value[key].getDouble(strict) : 0.0;
}

double getDouble(Json value, bool strict = true) {
  if (!strict) {
    if (value.isBoolean) {
      return value.get!bool ? 1.0 : 0.0;
    }
    if (value.isInteger) {
      return to!double(value.get!int);
    }
    if (value.isString) {
      return to!double(value.getString);
    }
  }

  return !value.isNull && (value.isFloat || value.isDouble)
    ? value.get!double : 0.0;
}
// #endregion get

// #region only
// #endregion only

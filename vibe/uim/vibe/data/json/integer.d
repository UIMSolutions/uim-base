/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.data.json.integer;

mixin(Version!("test_uim_vibe"));

import uim.vibe;
@safe:

// #region isInteger
mixin(CheckJsonIs!("Integer"));

unittest {
  assert(!Json(true).isInteger);
  assert(Json(10).isInteger);
  assert(!Json(1.1).isInteger);
  assert(!Json("text").isInteger);

  Json map = Json.emptyObject;
  map["a"] = Json(1);
  map["b"] = Json(2);
  map["c"] = Json(3.0);

  assert(map.isInteger("a") && map.isInteger("b"));
  assert(!map.isInteger("c"));

  assert(map.isAllInteger(["a", "b"]));
  assert(map.isAnyInteger(["a", "b"]));

  map["b"] = Json("B");
  assert(map.isInteger("a"));
  assert(!map.isInteger("b") && !map.isInteger("c"));

  assert(!map.isAllInteger(["a", "b"]));
  assert(map.isAnyInteger(["a", "b"]));

  map["a"] = Json("A");
  assert(!map.isInteger("a") && !map.isInteger("b") && !map.isInteger("c"));

  assert(!map.isAllInteger(["a", "b"]));
  assert(!map.isAnyInteger(["a", "b"]));

  // Json[]
  auto a = Json(1);
  auto b = Json(2);
  assert(a.isInteger("a") && b.isInteger("b"));

  assert(map.isAllInteger([a, b]));
  assert(map.isAnyInteger([a, b]));

  b = Json(2.0);
  assert(a.isInteger("a") && !b.isInteger("b"));

  assert(!map.isAllInteger([a, b]));
  assert(map.isAnyInteger([a, b]));

  a = Json(1.0);
  assert(!a.isInteger("a") && !b.isInteger("b"));
  assert(!map.isAllInteger([a, b]));
  assert(!map.isAnyInteger([a, b]));
}
// #region Json[]
unittest {
  auto values = [Json(1), Json(2)];
  assert(values.isAnyInteger);
  assert(values.isAllInteger);

  values = [Json("a"), Json(2)];
  assert(values.isAnyInteger);
  assert(!values.isAllInteger);

  values = [Json("a"), Json("b")];
  assert(!values.isAnyInteger);
  assert(!values.isAllInteger);

  assert(isAnyInteger([Json(1), Json(2)]));
  assert(isAnyInteger([Json("x"), Json(2)]));

  assert(!isAnyInteger([Json("x"), Json("y")]));
  assert(isAllInteger([Json(1), Json(2)]));

  assert(!isAllInteger([Json("x"), Json(2)]));
  assert(!isAllInteger([Json("x"), Json("y")]));
}
// #endregion Json[]

// #region Json[string]
unittest {
  Json[string] map;
  map["a"] = Json(1);
  map["b"] = Json(2);
  assert(map.isAllInteger(["a", "b"]));
  assert(map.isAnyInteger(["a", "b"]));

  map["b"] = Json("B");
  assert(!map.isAllInteger(["a", "b"]));
  assert(map.isAnyInteger(["a", "b"]));

  map["a"] = Json("A");
  assert(!map.isAllInteger(["a", "b"]));
  assert(!map.isAnyInteger(["a", "b"]));
}
// #endregion Json[string]

// #region Json
bool isInteger(Json value, bool strict = true) {
  if (!strict) {
    if (value.isString) {
      return Json(to!int(value.getString)).isInteger;
    }
  }

  return (value.type == Json.Type.int_);
}
// #endregion Json
// #endregion is

// #region get
mixin(GetJsonValue!("int", "Integer", "0"));

int getInteger(Json json, int defaultValue = 0) {
  return json.isInteger
    ? json.get!int : defaultValue;
}

unittest {
  Json json = Json(1);
  assert(json.getInteger == 1);

  json = Json.emptyArray;
  json ~= 1;
  json ~= 2;
  assert(json.getInteger(0) == 1);
  assert(json.getInteger(1) != 1);

  json = Json.emptyObject;
  json["One"] = 1;
  json["Two"] = 2;
  assert(json.getInteger("One") == 1);
  assert(json.getInteger("Two") != 1);

  auto list = [Json(1), Json(2)];
  assert(list.getInteger(0) == 1);
  assert(list.getInteger(1) != 1);

  auto map = ["One": Json(1), "Two": Json(2)];
  assert(map.getInteger("One") == 1);  
  assert(map.getInteger("Two") != 1);  
}
// #endregion get

// #region only
// #endregion only

// #region set  
// #endregion set

// #region remove
// #endregion remove

// #region clear
// #endregion clear

// #region to
// #endregion to
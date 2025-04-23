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

bool isInteger(Json value, string key) {
  return value.hasKey(key)
    ? value[key].isInteger : false;
}

bool isInteger(Json value) {
  return (value.type == Json.Type.int_);
}

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

  assert(map.allInteger("a", "b"));
  assert(map.allInteger(["a", "b"]));

  assert(map.anyInteger("a", "b"));
  assert(map.anyInteger(["a", "b"]));

  map["b"] = Json("B");
  assert(map.isInteger("a"));
  assert(!map.isInteger("b") && !map.isInteger("c"));

  assert(!map.allInteger("a", "b"));
  assert(!map.allInteger(["a", "b"]));

  assert(map.anyInteger("a", "b"));
  assert(map.anyInteger(["a", "b"]));

  map["a"] = Json("A");
  assert(!map.isInteger("a") && !map.isInteger("b") && !map.isInteger("c"));

  assert(!map.allInteger("a", "b"));
  assert(!map.allInteger(["a", "b"]));

  assert(!map.anyInteger("a", "b"));
  assert(!map.anyInteger(["a", "b"]));

  // Json[]
  auto a = Json(1);
  auto b = Json(2);
  assert(a.isInteger("a") && b.isInteger("b"));

  assert(map.allInteger(a, b));
  assert(map.allInteger([a, b]));

  assert(map.anyInteger(a, b));
  assert(map.anyInteger([a, b]));

  b = Json(2.0);
  assert(a.isInteger("a") && !b.isInteger("b"));

  assert(!map.allInteger(a, b));
  assert(!map.allInteger([a, b]));

  assert(map.anyInteger(a, b));
  assert(map.anyInteger([a, b]));

  a = Json(1.0);
  assert(!a.isInteger("a") && !b.isInteger("b"));

  assert(!map.allInteger(a, b));
  assert(!map.allInteger([a, b]));

  assert(!map.anyInteger(a, b));
  assert(!map.anyInteger([a, b]));
}
// #endregion isInteger

// #region get
int getInteger(Json value, size_t index) {
  return !value.isNull && value.isArray && value.length > index
    ? value[index].getInteger : 0;
}

int getInteger(Json value, string key) {
  return !value.isNull && value.isObject && value.hasKey(key)
    ? value[key].getInteger : 0;
}

int getInteger(Json value) {
  return !value.isNull && value.isInteger
    ? value.get!int : 0;
}

unittest {
  Json jValue = Json(1);

  Json jArray = Json.emptyArray;
  jArray ~= 1;
  jArray ~= 2;

  Json jObject = Json.emptyObject;
  jObject["one"] = 1;
  jObject["two"] = 2;

  assert(jValue.getInteger == 1); // == true
  assert(jArray.getInteger(0) == 1); // == true
  assert(jObject.getInteger("one") == 1); // == true
}
// #endregion get

// #region only
// #endregion only
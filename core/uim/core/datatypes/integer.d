/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.core.datatypes.integer;

mixin(Version!("test_uim_core"));

import uim.core;
@safe:

// #region isInteger
// #region Json[]
bool isAnyInteger(Json[] values...) {
  return isAnyInteger(values.dup);
}

bool isAnyInteger(Json[] values) {
  return values.any!(value => value.isInteger);
}

bool isAllInteger(Json[] values...) {
  return isAllInteger(values.dup);
}

bool isAllInteger(Json[] values) {
  return values.all!(value => value.isInteger);
}

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

  assert(isAnyInteger(Json(1), Json(2)));
  assert(isAnyInteger([Json(1), Json(2)]));

  assert(isAnyInteger(Json("x"), Json(2)));
  assert(isAnyInteger([Json("x"), Json(2)]));

  assert(!isAnyInteger(Json("x"), Json("y")));
  assert(!isAnyInteger([Json("x"), Json("y")]));

  assert(isAllInteger(Json(1), Json(2)));
  assert(isAllInteger([Json(1), Json(2)]));

  assert(!isAllInteger(Json("x"), Json(2)));
  assert(!isAllInteger([Json("x"), Json(2)]));

  assert(!isAllInteger(Json("x"), Json("y")));
  assert(!isAllInteger([Json("x"), Json("y")]));
}
// #endregion Json[]

// #region Json[string]
bool isAnyInteger(Json[string] map, string[] keys...) {
  return map.isAnyInteger(keys.dup);
}

bool isAnyInteger(Json[string] map, string[] keys) {
  return keys.any!(key => map.isInteger(key));
}

bool isAllInteger(Json[string] map, string[] keys...) {
  return map.isAllInteger(keys.dup);
}

bool isAllInteger(Json[string] map, string[] keys) {
  return keys.all!(key => map.isInteger(key));
}

bool isInteger(Json[string] items, string key) {
  return items.hasKey(key)
    ? items[key].isInteger : false;
}
unittest {
  Json[string] map;
  map["a"] = Json(1);
  map["b"] = Json(2);
  assert(map.isAllInteger("a", "b"));
  assert(map.isAllInteger(["a", "b"]));

  assert(map.isAnyInteger("a", "b"));
  assert(map.isAnyInteger(["a", "b"]));

  map["b"] = Json("B");
  assert(!map.isAllInteger("a", "b"));
  assert(!map.isAllInteger(["a", "b"]));

  assert(map.isAnyInteger("a", "b"));
  assert(map.isAnyInteger(["a", "b"]));

  map["a"] = Json("A");
  assert(!map.isAllInteger("a", "b"));
  assert(!map.isAllInteger(["a", "b"]));

  assert(!map.isAnyInteger("a", "b"));
  assert(!map.isAnyInteger(["a", "b"]));
}
// #endregion Json[string]

// #endregion isInteger

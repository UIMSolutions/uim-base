/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.core.datatypes.booleans.boolean;

import uim.core;

mixin(Version!("test_uim_core"));
@safe:

// char[] BOOL(bool toogleValue) { return cast(char[])((toogleValue) ? `true`:`false`); }

// #region toogle
/// Toggle boolean value (from true to false, false to true) -> in this function it's !value
bool toggle(bool value) {
  return !value;
}

unittest {
  assert(toggle(true) == false, "toggle(true) should return false");
  assert(toggle(false) == true, "toggle(false) should return true");
  // Double toggle returns original value
  assert(toggle(toggle(true)) == true, "toggle(toggle(true)) should return true");
  assert(toggle(toggle(false)) == false, "toggle(toggle(false)) should return false");
}
// #endregion toogle

// #region isBoolean

// #endregion isBoolean

// #region translate
/// Translates boolean to defined values
pure T translateTo(T)(bool value, T trueValue, T falseValue) {
  return (value) ? trueValue : falseValue;
}

unittest {
  assert(translateTo(true, false, true) == false, "Error in translate(bool, T, T)");
  assert(translateTo(false, false, true) == true, "Error in translate(bool, T, T)");

  assert(translateTo(true, "YES", "NO") == "YES", "Error in translate(bool, T, T)");
  assert(translateTo(false, "YES", "NO") == "NO", "Error in translate(bool, T, T)");

  assert(translateTo(true, 1, 2) == 1, "Error in translate(bool, T, T)");
  assert(translateTo(false, 1, 2) == 2, "Error in translate(bool, T, T)");

  assert(translateTo(true, 1, 2) == 1, "Error in translate(bool, T, T)");
  assert(translateTo(false, 1, 2) == 2, "Error in translate(bool, T, T)");
}
// #endregion translateTo

// #region ifBoolean
Json ifBoolean(Json value, Json booleanValue) {
  return value.isBoolean ? booleanValue : value;
}

Json ifBoolean(Json obj, string key, Json booleanValue) {
  return obj.hasKey(key) && obj[key].isBoolean ? booleanValue : obj[key];
}

Json ifBoolean(Json[string] map, string key, Json booleanValue) {
  return map.hasKey(key) && map[key].isBoolean ? booleanValue : map[key];
}

unittest {
  auto value = Json(true);
  assert(value.ifBoolean(Json(1)) == Json(1));

  value = Json("abc");
  assert(value.ifBoolean(Json(1)) == Json("abc"));

  value = Json.emptyObject;
  value["a"] = Json(true);
  value["b"] = Json(100);
  assert(value.ifBoolean("a", Json(1)) == Json(1));
  assert(value.ifBoolean("b", Json(50)) == Json(100));

  Json[string] map;
  map["a"] = Json(true);
  map["b"] = Json(100);
  assert(map.ifBoolean("a", Json(1)) == Json(1));
  assert(map.ifBoolean("b", Json(50)) == Json(100));
}
// #endregion ifBoolean

// #region ifNotBoolean
Json ifNotBoolean(Json value, Json notBooleanValue) {
  return value.isBoolean ? value : notBooleanValue;
}

Json ifNotBoolean(Json obj, string key, Json notBooleanValue) {
  return obj.hasKey(key) && obj[key].isBoolean ? obj[key] : notBooleanValue;
}

Json ifNotBoolean(Json[string] map, string key, Json notBooleanValue) {
  return map.hasKey(key) && map[key].isBoolean ? map[key] : notBooleanValue;
}

unittest {
  auto value = Json(true);
  assert(value.ifNotBoolean(Json(1)) == Json(true));

  value = Json("abc");
  assert(value.ifNotBoolean(Json(1)) != Json(true));
  assert(value.ifNotBoolean(Json(1)) == Json(1));

  value = Json.emptyObject;
  value["a"] = Json(true);
  value["b"] = Json(100);
  assert(value.ifNotBoolean("a", Json(1)) == Json(true));
  assert(value.ifNotBoolean("b", Json(50)) == Json(50));

  Json[string] map;
  map["a"] = Json(true);
  map["b"] = Json(100);
  assert(map.ifNotBoolean("a", Json(1)) == Json(true));
  assert(map.ifNotBoolean("b", Json(100)) == Json(100));
}
// #endregion ifNotBoolean

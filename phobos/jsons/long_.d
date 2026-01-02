/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.long_;

import uim.root;
mixin(Version!("show_uim_root"));

@safe:

// #region is
// Check if the Json value is a long integer.

// #region Json[string]
/// Check if all values in the map are long integers.
bool isAllLong(Json[string] map) {
  return map.byValue.all!(value => value.isLong);
}

/// Check if all values associated with the specified keys in the map are long integers.
bool isAllLong(Json[string] map, string[] keys) {
  return keys.all!(key => map.isLong(key));
}

bool isAnyLong(Json[string] map) {
  return map.byValue.any!(value => value.isLong);
}

/// Check if any value associated with the specified keys in the map is a long integer.
bool isAnyLong(Json[string] map, string[] keys) {
  return keys.any!(index => map.isLong(index));
}

/// Check if the value associated with the specified key in the map is a long integer.
bool isLong(Json[string] map, string key) {
  return key in map && map[key].isLong;
}
// #endregion Json[string]

// #region Json[]
bool isAllLong(Json[] values) {
  return values.all!(value => value.isLong);
}

bool isAllLong(Json[] values, size_t[] indices) {
  return indices.all!(index => values.isLong(index));
}

bool isAnyLong(Json[] values) {
  return values.any!(value => value.isLong);
}

bool isAnyLong(Json[] values, size_t[] indices) {
  return indices.any!(index => values.isLong(index));
}

bool isLong(Json[] values, size_t index) {
  return values.length > index && values[index].isLong;
}
// #endregion Json[]

// #region Json
bool isAllLong(Json json) {
  if (json.isObject) {
    return isAllLong(json.to!(Json[string]));
  }
  if (json.isArray) {
    return isAllLong(json.to!(Json[]));
  }
  return json.isLong;
}

bool isAllLong(Json json, string[] keys) {
  return keys.all!(key => json.isLong(key));
}

bool isAnyLong(Json json) {
  if (json.isObject) {
    return isAnyLong(json.to!(Json[string]));
  }
  if (json.isArray) {
    return isAnyLong(json.to!(Json[]));
  }
  return json.isLong;
}

bool isAnyLong(Json json, string[] keys) {
  return keys.any!(key => json.isLong(key));
}

bool isLong(Json json, string[] path) {
  if (json.isNull) {
    return true;
  }

  if (path.length == 0 && json == Json(null)) {
    return true;
  }

  if (path.length == 0 && json == Json(null)) {
    return false;
  }

  auto key = path[0];
  return path.length == 1
    ? json.isLong(key) : json.hasKey(key) && json[key].isLong(path[1 .. $]);
}

bool isLong(Json json, string key) {
  return key in json && json[key].isLong;
}

bool isLong(Json value) {
  return (value.type == Json.Type.int_);
}
///
unittest { // Json
  assert(!Json(true).isLong);
  assert(Json(10).isLong);
  assert(!Json(1.1).isLong);
  assert(!Json("text").isLong);
}

unittest { // Json[]
  auto a = Json(1);
  auto b = Json(2);
  auto c = Json("1");
  auto d = Json(1.1);
  auto list = [a, b, c, d];
  assert([a, b].isAllLong);
  assert(![a, c].isAllLong);

  assert(list.isAllLong([0, 1]));
  assert(!list.isAllLong([2, 3]));

  assert([a, b].isAnyLong);
  assert([a, c].isAnyLong);
  assert(![c, d].isAnyLong);

  assert(list.isAnyLong([0, 1]));
  assert(list.isAnyLong([1, 2]));
  assert(!list.isAnyLong([2, 3]));
}

unittest { // Json[string]
  auto a = Json(1);
  auto b = Json(2);
  auto c = Json("1");
  auto d = Json(1.1);

  /*   auto map = [1: a, 2: b, "C": c, "D": d];
  assert([1: a, 2: b].isAllLong);
  assert(![1: a, "C": c].isAllLong);

  assert(map.isAllLong([1, 2]));
  assert(map.isAllLong([1, "C"]));

  assert([1: a, 2: b].isAnyLong);
  assert([1: a, "C": c].isAnyLong);
  assert(!["C": c, "D": d].isAnyLong);

  assert(map.isAnyLong([1, 2]));
  assert(map.isAnyLong([1, "C"]));
  assert(map.isAnyLong(["C", "D"])); */
}
// #endregion is

// #region get
long getLong(Json json) {
  return json.isLong
    ? json.get!long : 0;
}

unittest {
  Json json = Json(1);
  assert(json.getLong == 1);

  json = Json.emptyArray;
  json ~= 1;
  json ~= 2;
  assert(json.getLongAt(0) == 1);
  assert(json.getLongAt(1) == 2);

  json = Json.emptyObject;
  json["One"] = 1;
  json["Two"] = 2;
  assert(json.getLong("One") == 1);
  assert(json.getLong("Two") == 2);

  auto list = [Json(1), Json(2)];
  assert(list.getLongAt(0) == 1);
  assert(list.getLongAt(1) != 1);

  auto map = ["One": Json(1), "Two": Json(2)];
  assert(map.getLong("One") == 1);
  assert(map.getLong("Two") != 1);
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

/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.datatypes.json.integer;

mixin(Version!("test_uim_vibe"));

import uim.vibe;

@safe:

// #region isInteger
// #region Json[string]
bool isAllInteger(Json[string] map, bool strict = true) {
  return map.byValue.all!(value => value.isInteger(strict));
}

bool isAllInteger(Json[string] map, string[] keys, bool strict = true) {
  return keys.all!(key => map.isInteger(key, strict));
}

bool isAnyInteger(Json[string] map, bool strict = true) {
  return map.byValue.any!(value => value.isInteger(strict));
}

bool isAnyInteger(Json[string] map, string[] keys, bool strict = true) {
  return keys.any!(index => map.isInteger(index));
}

bool isInteger(Json[string] map, string key, bool strict = true) {
  return key in map && map[key].isInteger(strict);
}
// #endregion Json[string]

// #region Json[]
bool isAllInteger(Json[] values, bool strict = true) {
  return values.all!(value => value.isInteger(strict));
}

bool isAllInteger(Json[] values, size_t[] indices, bool strict = true) {
  return indices.all!(index => values.isInteger(index, strict));
}

bool isAnyInteger(Json[] values, bool strict = true) {
  return values.any!(value => value.isInteger(strict));
}

bool isAnyInteger(Json[] values, size_t[] indices, bool strict = true) {
  return indices.any!(index => values.isInteger(index, strict));
}

bool isInteger(Json[] values, size_t index, bool strict = true) {
  return values.length > index && values[index].isInteger(strict);
}
// #endregion Json[]

// #region Json
bool isAllInteger(Json json, bool strict = true) {
  if (json.isObject) {
    return isAllInteger(json.to!(Json[string]), strict);
  }
  if (json.isArray) {
    return isAllInteger(json.to!(Json[]), strict);
  }
  return json.isInteger(strict);
}

bool isAllInteger(Json json, string[] keys, bool strict = true) {
  return keys.all!(key => json.isInteger(key, strict));
}

bool isAnyInteger(Json json, bool strict = true) {
  if (json.isObject) {
    return isAnyInteger(json.to!(Json[string]), strict);
  }
  if (json.isArray) {
    return isAnyInteger(json.to!(Json[]), strict);
  }
  return json.isInteger(strict);
}

bool isAnyInteger(Json json, string[] keys, bool strict = true) {
  return keys.any!(key => json.isInteger(key, strict));
}

bool isInteger(Json json, string[] path, bool strict = true) {
  if (json.isNull) {
    return true;
  }

  if (path.length == 0 && json == Null!Json) {
    return true;
  }

  if (path.length == 0 && json == Null!Json) {
    return false;
  }

  auto key = path[0];
  return path.length == 1
    ? json.isInteger(key, strict) : json.hasKey(key) && json[key].isInteger(path[1 .. $], strict);
}

bool isInteger(Json json, string key, bool strict = true) {
  return key in json && json[key].isInteger(strict);
}
// #endregion Json

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
  auto list = [Json(1), Json(2)];
  assert(list[0].isInteger && list[1].isInteger);

  assert(list.isAllInteger);
  assert(list.isAnyInteger);

  list[1] = Json(2.0);
  assert(list[0].isInteger && !list[1].isInteger);

  assert(!list.isAllInteger);
  assert(list.isAnyInteger);

  list[0] = Json(1.0);
  assert(!list[0].isInteger && !list[1].isInteger);
  assert(!list.isAllInteger);
  assert(!list.isAnyInteger);
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

int getInteger(Json json) {
  return json.isInteger
    ? json.get!int : 0;
}

unittest {
  Json json = Json(1);
  assert(json.getInteger == 1);

  json = Json.emptyArray;
  json ~= 1;
  json ~= 2;
  assert(json.getIntegerAt(0) == 1);
  assert(json.getIntegerAt(1) != 1);

  json = Json.emptyObject;
  json["One"] = 1;
  json["Two"] = 2;
  assert(json.getInteger("One") == 1);
  assert(json.getInteger("Two") != 1);

  auto list = [Json(1), Json(2)];
  assert(list.getIntegerAt(0) == 1);
  assert(list.getIntegerAt(1) != 1);

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

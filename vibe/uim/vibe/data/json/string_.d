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

// #region Json[string]
bool isAllString(Json[string] map, bool strict = true) {
  return map.byValue.all!(value => value.isString(strict));
}

bool isAllString(Json[string] map, string[] keys, bool strict = true) {
  return keys.all!(key => map.isString(key, strict));
}

bool isAnyString(Json[string] map, bool strict = true) {
  return map.byValue.any!(value => value.isString(strict));
}

bool isAnyString(Json[string] map, string[] keys = null, bool strict = true) {
  return keys.any!(key => map.isString(key, strict));
}

bool isString(Json[string] map, string[] path, bool strict = true) {
  if (path.length == 0) {
    return false;
  }

  auto key = path[0];
  return path.length == 1
    ? map.isString(key, strict) : key in map && map[key].isString(path[1 .. $], strict);
}

bool isString(Json[string] map, string key, bool strict = true) {
  return key in map && map[key].isString(strict);
}
unittest {
  Json[string] map;
  map["a"] = Json("a");
  map["b"] = Json("b");

  assert(map.allString(["a", "b"]));
  assert(map.anyString(["a", "b"]));

  map["b"] = Json(8);
  assert(!map.allString(["a", "b"]));
  assert(map.anyString(["a", "b"]));

  map["a"] = Json(true);
  assert(!map.allString(["a", "b"]));
  assert(!map.isAnyString(["a", "b"]));
}
// #endregion Json[string]

// #region Json[]
bool isAllString(Json[] values, bool strict = true) {
  return values.all!(value => value.isString);
}

bool isAllString(Json[] values, size_t[] indices, bool strict = true) {
  return indices.all!(index => values.isString(index));
}

bool isAnyString(Json[] values, bool strict = true) {
  return values.any!(value => value.isString(strict));
}

bool isAnyString(Json[] values, size_t[] indices, bool strict = true) {
  return indices.any!(index => values.isString(index));
}

bool isString(Json[] values, size_t index, bool strict = true) {
  return values.length > index && values[index].isString(strict);
}

unittest {
  auto values = [Json("a"), Json("b")];
  assert(values.isAnyString);
  assert(values.isAllString);

  values = [Json("a"), Json(3)];
  assert(values.isAnyString);
  assert(!values.isAllString);

  values = [Json(4), Json(5)];
  assert(!values.isAnyString);
  assert(!values.isAllString);

  assert(isAnyString([Json("a"), Json("b")]));
  assert(isAnyString([Json(7), Json("b")]));

  assert(!isAnyString([Json(7), Json(8)]));
  assert(isAllString([Json("a"), Json("b")]));

  assert(!isAllString([Json(7), Json("b")]));
  assert(!isAllString([Json(7), Json(8)]));
}
// #endregion Json[]

// #region Json
bool isAllString(Json json, bool strict = true) {
  if (json.isNull) {
    return false;
  }

  if (json.isString) {
    return true;
  }

  if (json.isArray) {
    return isAllString(json.to!(Json[]), strict);
  }

  if (json.isObject) {
    return isAllString(json.to!(Json[string]), strict);
  }

  return false;
}

bool isAllString(Json json, string[] keys, bool strict = true) {
  return json.isObject && keys.all!(key => json.isString(key, strict));
}

bool isAnyString(Json json, bool strict = true) {
  if (json.isNull) {
    return false;
  }

  if (json.isString) {
    return true;
  }

  if (json.isArray) {
    return isAnyString(json.to!(Json[]), strict);
  }

  if (json.isObject) {
    return isAnyString(json.to!(Json[string]), strict);
  }

  return false;
}

bool isAnyString(Json json, string[] keys, bool strict = true) {
  return json.isObject && keys.any!(key => json.isString(key, strict));
}

bool isString(Json json, string[] path, bool strict = true) {
  if (json.isNull) {
    return false;
  }

  if (path.length == 0 && json == Json(null)) {
    return false;
  }

  auto key = path[0];
  return path.length == 1
    ? json.isString(key, strict) : json.hasKey(key) && json[key].isString(path[1 .. $], strict);
}

bool isString(Json json, string key, bool strict = true) {
  return json.isObject && json.hasKey(key) && json[key].isString(strict);
}

bool isString(Json json, bool strict = true) {
  if (json.isNull) {
    return false;
  }

  if (strict) { // strict check for future use
    return json.isString;
  }

  return (json.type == Json.Type.string);
}
// #endregion Json



unittest {
  assert(parseJsonString(`"a"`).isString);
  assert(!parseJsonString(`1.1`).isString);

  auto json = parseJsonString(`{"a": "b", "c": {"d": 1}, "e": ["f", {"g": 1.1}], "i": {"j": "x"}}`);
  assert(json.isString("a"));
  assert(!json.isString("c"));
  assert(json.isString(["i", "j"]));
  assert(!json.isString(["e", "g"]));
}

unittest {
  assert(!Json(true).isString);
  assert(!Json(10).isString);
  assert(!Json(1.1).isString);
  assert(Json("text").isString);

  Json map = Json.emptyObject;
  map["a"] = Json("a");
  map["b"] = Json("b");
  assert(map.isAllString(["a", "b"]));
  assert(map.isAnyString(["a", "b"]));

  map["b"] = Json(9);
  assert(!map.isAllString(["a", "b"]));
  assert(map.isAnyString(["a", "b"]));

  map["a"] = Json(true);
  assert(!map.isAllString(["a", "b"]));
  assert(!map.isAnyString(["a", "b"]));
}
// #endregion Json

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

// #region isString

// #endregion isString

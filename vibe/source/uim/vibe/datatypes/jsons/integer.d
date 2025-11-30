/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.integer;

import uim.vibe;
mixin(Version!("test_uim_vibe"));

@safe:

// #region is
// #region Json[]
bool allInteger(Json[] values, bool strict = true) {
  return values.all!(value => value.isInteger(strict));
}

bool allInteger(Json[] values, size_t[] indices, bool strict = true) {
  return indices.all!(index => values.isInteger(index, strict));
}

bool anyInteger(Json[] values, bool strict = true) {
  return values.any!(value => value.isInteger(strict));
}

bool anyInteger(Json[] values, size_t[] indices, bool strict = true) {
  return indices.any!(index => values.isInteger(index, strict));
}

bool isInteger(Json[] values, size_t index, bool strict = true) {
  return values.length > index && values[index].isInteger(strict);
}
// #endregion Json[]

// #region isInteger(Json)
bool allInteger(Json json, bool strict = true) {
  if (json.isObject) {
    return allInteger(json.to!(Json[string]), strict);
  }
  if (json.isArray) {
    return allInteger(json.to!(Json[]), strict);
  }
  return json.isInteger(strict);
}

bool allInteger(Json json, string[][] paths, bool strict = true) {
  return paths.all!(path => json.isInteger(path, strict));
}

bool allInteger(Json json, string[] keys, bool strict = true) {
  return keys.all!(key => json.isInteger(key, strict));
}

bool anyInteger(Json json, bool strict = true) {
  if (json.isObject) {
    return anyInteger(json.to!(Json[string]), strict);
  }
  if (json.isArray) {
    return anyInteger(json.to!(Json[]), strict);
  }
  return json.isInteger(strict);
}

bool anyInteger(Json json, string[][] paths, bool strict = true) {
  return paths.any!(path => json.isInteger(path, strict));
}

bool anyInteger(Json json, string[] keys, bool strict = true) {
  return keys.any!(key => json.isInteger(key, strict));
}

bool isInteger(Json json, string[] path, bool strict = true) {
  if (json.isNull || path.length == 0) {
    return false;
  }

  if (!json.isObject || !json.hasKey(path[0])) {
    return false;
  }

  if (path.length == 1) {
    return json.isInteger(path[0], strict);
  }

  return json[path[0]].isInteger(path[1 .. $], strict);
}

bool isInteger(Json json, string key, bool strict = true) {
  if (json.isNull || key.length == 0) {
    return false;
  }

  if (!json.isObject || !json.hasKey(key)) {
    return false;
  }

  return json[key].isInteger(strict);
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

  assert(map.allInteger(["a", "b"]));
  assert(map.anyInteger(["a", "b"]));

  map["b"] = Json("B");
  assert(map.isInteger("a"));
  assert(!map.isInteger("b") && !map.isInteger("c"));

  assert(!map.allInteger(["a", "b"]));
  assert(map.anyInteger(["a", "b"]));

  map["a"] = Json("A");
  assert(!map.isInteger("a") && !map.isInteger("b") && !map.isInteger("c"));

  assert(!map.allInteger(["a", "b"]));
  assert(!map.anyInteger(["a", "b"]));

  // Json[]
  auto list = [Json(1), Json(2)];
  assert(list[0].isInteger && list[1].isInteger);

  assert(list.allInteger);
  assert(list.anyInteger);

  list[1] = Json(2.0);
  assert(list[0].isInteger && !list[1].isInteger);

  assert(!list.allInteger);
  assert(list.anyInteger);

  list[0] = Json(1.0);
  assert(!list[0].isInteger && !list[1].isInteger);
  assert(!list.allInteger);
  assert(!list.anyInteger);
}
// #endregion isInteger(Json)

// #region Json[]
unittest {
  auto values = [Json(1), Json(2)];
  assert(values.anyInteger);
  assert(values.allInteger);

  values = [Json("a"), Json(2)];
  assert(values.anyInteger);
  assert(!values.allInteger);

  values = [Json("a"), Json("b")];
  assert(!values.anyInteger);
  assert(!values.allInteger);

  assert(anyInteger([Json(1), Json(2)]));
  assert(anyInteger([Json("x"), Json(2)]));

  assert(!anyInteger([Json("x"), Json("y")]));
  assert(allInteger([Json(1), Json(2)]));

  assert(!allInteger([Json("x"), Json(2)]));
  assert(!allInteger([Json("x"), Json("y")]));
}
// #endregion Json[]

// #region Json[string]
unittest {
  Json[string] map;
  map["a"] = Json(1);
  map["b"] = Json(2);
  assert(map.allInteger(["a", "b"]));
  assert(map.anyInteger(["a", "b"]));

  map["b"] = Json("B");
  assert(!map.allInteger(["a", "b"]));
  assert(map.anyInteger(["a", "b"]));

  map["a"] = Json("A");
  assert(!map.allInteger(["a", "b"]));
  assert(!map.anyInteger(["a", "b"]));
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

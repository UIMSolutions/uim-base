/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.json.types.string_;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

/** 
  * Checks if the given JSON value at the specified path is of string type.
  *
  * Params:
  *   json = The JSON value to check.
  *   path = The path within the JSON object to check.
  *
  * Returns:
  *   `true` if the JSON value at the specified path is a string, `false` otherwise.
  */
bool isString(Json json, string[] path) {
  if (json.isNull || !json.hasPath(path)) {
    return false;
  }

  auto firstKey = path[0];
  if (json.isString(firstKey)) {
    return true;
  }

  return path.length > 1 && json[firstKey].isString(path[1 .. $]);
}

/**
  * Checks if the given JSON value at the specified key is of string type.
  *
  * Params:
  *   json = The JSON value to check.
  *   key  = The key within the JSON object to check.
  *
  * Returns:
  *   `true` if the JSON value at the specified key is a string, `false` otherwise.
  */
bool isString(Json json, string key) {
  return json.hasKey(key) && json[key].isString;
}

/** 
  * Checks if the given JSON value is of string type.
  *
  * Params:
  *   json = The JSON value to check.
  *
  * Returns:
  *   `true` if the JSON value is a string, `false` otherwise.
  */
bool isString(Json json) {
  return (json.type == Json.Type.string);
}
///
unittest {
  auto json = parseJsonString(`{"a": "b", "c": {"d": 1}, "e": ["f", {"g": 1.1}], "i": {"j": "x"}}`);
  assert(json.isString("a"));
  assert(!json.isString("c"));
  assert(json.isString(["i", "j"])); // Check path i/j
  assert(!json.isString(["e", "g"])); // Check path e/g

  auto a = Json("a");
  assert(a.isString);
  assert(!a.isInteger);

  auto b = Json("b");
  auto c = Json(1);

  assert([a, b].isAnyString);
  assert([a, c].isAnyString);

  assert([a, b].isAllString);
  assert(![a, c].isAllString);

  auto map = ["A": a, "B": b, "C": c];
  assert(map.isAnyString(["A", "B"]));
  assert(map.isAnyString(["A", "C"]));

  assert(map.isAllString(["A", "B"]));
  assert(!map.isAllString(["A", "C"]));
}
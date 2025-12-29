/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.types.scalars.is_;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

/** 
  * Checks if the given JSON value at the specified path is of scalar type.
  *
  * Params:
  *   json = The JSON value to check.
  *   path = The path within the JSON object to check.
  *
  * Returns:
  *   `true` if the JSON value at the specified path is a scalar, `false` otherwise.
  */
bool isScalar(Json json, string[] path) {
  if (json.isNull || !json.hasPath(path)) {
    return false;
  }

  auto firstKey = path[0];
  if (json.isScalar(firstKey)) {
    return true;
  }

  return path.length > 1 && json[firstKey].isScalar(path[1 .. $]);
}

/**
  * Checks if the given JSON value at the specified key is of scalar type.
  *
  * Params:
  *   json = The JSON value to check.
  *   key  = The key within the JSON object to check.
  *
  * Returns:
  *   `true` if the JSON value at the specified key is a scalar, `false` otherwise.
  */
bool isScalar(Json json, string key) {
  return json.hasKey(key) && json[key].isScalar;
}

/** 
  * Checks if the given JSON value is of scalar type.
  *
  * Params:
  *   value = The JSON value to check.
  *
  * Returns:
  *   `true` if the JSON value is a scalar, `false` otherwise.
  */
bool isScalar(Json value) {
  return !value.isArray && !value.isObject;
}
///
unittest {
  Json json = Json.fromString(`
  {
    "name": "John",
    "age": 30,
    "isStudent": false,
    "scores": [85, 90, 78],
    "address": {
      "city": "New York",
      "zip": "10001"
    }
  }
  `);

  assert(json.isScalar("name"));
  assert(!json.isScalar("scores"));
  assert(!json.isScalar("address"));
  assert(json.isScalar("age"));
  assert(json.isScalar("isStudent"));
  assert(json.isScalar(["address", "city"]));
  assert(!json.isScalar(["address", "zip", "extra"]));
  assert(!json.isScalar(["scores", "0"]));
  assert(!json.isScalar(["nonexistent"]));
}

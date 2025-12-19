/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.json.types.strings.is_;

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


// #endregion scalar
/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.types.strings.is_;

import uim.root;

mixin(Version!("test_uim_root"));

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
  return json.getPath(path).isString;
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
  return json.hasKey(key).isString;
}
// #endregion scalar
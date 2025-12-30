/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.read;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

/** 
  * Retrieves the Json value.
  *
  * Params:
  *   json = The JSON value to retrieve.
  *   defaultValue = The default JSON value to return if the original is null (default is Json(null)).
  *
  * Returns:
  *   The JSON value or the default value if the original is null.
  */
Json getJson(Json json, Json defaultValue = Json(null)) {
  return json;
}
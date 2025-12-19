/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.json.types.booleans.has;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

bool hasAllKey(Json json, string[] keys) {
  return keys.all!(key => hasKey(json, key));
}

bool hasAnyKey(Json json, string[] keys) {
  return keys.any!(key => hasKey(json, key));
}

bool hasKey(Json json, string key) {
  return (key in json);
}
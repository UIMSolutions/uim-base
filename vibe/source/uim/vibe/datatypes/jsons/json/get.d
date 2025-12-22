/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject get the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.json.get;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

Json[] getArray(Json json) {
  return json.isArray
    ? json.get!(Json[]) : null;
}

Json[string] getMap(Json json) {
  return json.isObject
    ? json.get!(Json[string]) : null;
}





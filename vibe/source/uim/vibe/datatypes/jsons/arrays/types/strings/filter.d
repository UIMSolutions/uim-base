/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.strings.filter;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

Json[] filterStrings(Json[] jsons, bool delegate(Json json) @safe filterFunc) {
  return jsons.filterStrings.filter!(json => filterFunc(json)).array;
}

Json[] filterStrings(Json[] jsons, size_t[] indices) {
  return jsons.filterValues(indices).filterStrings.array;
}

Json[] filterStrings(Json[] jsons) {
  return jsons.filter!(json => json.isString).array;
}

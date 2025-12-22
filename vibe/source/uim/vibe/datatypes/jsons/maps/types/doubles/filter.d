/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.maps.types.doubles.filter;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

Json[string] filterDoubles(Json[string] items, bool delegate(Json json) @safe filterFunc) {
  return items.filterDoubles.filter!(json => filterFunc(json)).array;
}

Json[] filterDoubles(Json[string] items, string[] keys) {
  return items.filterKeys(keys).filter!(json => json.isDouble).array;
}

Json[string] filterDoubles(Json[string] items) {
  return items.byValue.array.filter!(json => json.isDouble).array;
}

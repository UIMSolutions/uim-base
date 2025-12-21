/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.doubles.filter;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

Json[] filterDoubles(Json[] jsons, bool delegate(Json json) @safe filterFunc) {
  return jsons.filterDoubles.filter!(json => filterFunc(json)).array;
}

Json[] filterDoubles(Json[] jsons, size_t[] indices) {
  import uim.vibe.datatypes.jsons.arrays.types.doubles.filter;
  return filterValues(jsons, indices).filterDoubles.array;
}

Json[] filterDoubles(Json[] jsons) {
  return jsons.filter!(item => item.isDouble).array;
}

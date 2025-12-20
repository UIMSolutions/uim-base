/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.scalars.filter;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

Json[] filterScalars(Json[] jsons, bool delegate(Json json) @safe filterFunc) {
  return jsons.filterScalars.filter!(json => filterFunc(json)).array;
}

Json[] filterScalars(Json[] jsons, size_t[] indices) {
  return jsons.filterIndices(indices).filterScalars.array;
}

Json[] filterScalars(Json[] jsons) {
  return jsons.filter!(json => json.isScalar).array;
}

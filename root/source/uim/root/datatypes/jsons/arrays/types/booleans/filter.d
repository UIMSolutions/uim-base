/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.arrays.types.booleans.filter;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

Json[] filterBooleans(Json[] jsons, bool delegate(Json json) filterFunc) {
  Json[] results;
  () @trusted { results = jsons.filterBooleans.filter!(json => filterFunc(json)).array; }();
  return results;
}

Json[] filterBooleans(Json[] jsons, size_t[] indices) {
  return jsons.filterValues(indices).filterBooleans.array;
}

Json[] filterBooleans(Json[] jsons) {
  return jsons.filter!(json => json.isBoolean).array;
}

/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.arrays.types.doubles.filter;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

Json[] filterDoubles(Json[] jsons, bool delegate(Json json) @safe filterFunc) {
  return jsons.filterDoubles.filterValues((Json json) => filterFunc(json));
}

Json[] filterDoubles(Json[] jsons, size_t[] indices) {
  import uim.root.datatypes.jsons.arrays.types.doubles.filter;
  return filterValues(jsons, indices).filterDoubles;
}

Json[] filterDoubles(Json[] jsons) {
  return jsons.filterValues((Json json) => json.isDouble);
}

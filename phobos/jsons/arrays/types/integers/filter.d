/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.arrays.types.integers.filter;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

Json[] filterIntegers(Json[] jsons, bool delegate(Json json) @safe filterFunc) {
  return jsons.filterIntegers.filterValues(filterFunc);
}

Json[] filterIntegers(Json[] jsons, size_t[] indices) {
  return jsons.filterValues(indices).filterIntegers;
}

Json[] filterIntegers(Json[] jsons) {
  return jsons.filterValues((Json json) => json.isInteger);
}

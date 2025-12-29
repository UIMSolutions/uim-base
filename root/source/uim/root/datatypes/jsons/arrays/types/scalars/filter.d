/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.arrays.types.scalars.filter;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

Json[] filterScalars(Json[] jsons, bool delegate(Json json) filterFunc) {
  return jsons.filterScalars.filterValues(filterFunc);
}

Json[] filterScalars(Json[] jsons, bool delegate(Json json) @safe filterFunc) {
  return jsons.filterScalars.filterValues(filterFunc);
}

Json[] filterScalars(Json[] jsons, size_t[] indices) {
  return jsons.filterValues(indices).filterScalars;
}

Json[] filterScalars(Json[] jsons) {
  return jsons.filterValues((Json json) => json.isScalar);
}

/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.arrays.filter;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

// #region arrays
Json[] filterArrays(Json[] jsons, bool delegate(Json json) @safe filterFunc) {
  return jsons.filterArrays.filter!(json => filterFunc(json)).array;
}

Json[] filterArrays(Json[] jsons, size_t[] indices) {
  return jsons.filterValues(indices).filterArrays.array;
}

Json[] filterArrays(Json[] jsons) {
  return jsons.filter!(json => json.isArray).array;
}
// #endregion arrays

// #region indices
Json[] filterValues(Json[] jsons, size_t[] indices) {
  return indices.filter!(index => jsons.length > index).map!(index => jsons[index]).array;
}
// #region endindices

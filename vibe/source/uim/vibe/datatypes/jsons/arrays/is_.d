/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.is_;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region all
bool isAllArray(Json[] jsons, size_t[] indices = null) {
  import uim.vibe.datatypes.jsons.typecheck;
  return (indices is null) 
    ? jsons.all!(json => uim.vibe.datatypes.jsons.typecheck.isArray(json)) 
    : indices.all!(index => jsons.isArray(index));
}
// #endregion all

// #region any
bool isAnyArray(Json[] jsons, size_t[] indices = null) {
  import uim.vibe.datatypes.jsons.typecheck;
  return (indices is null) 
    ? jsons.any!(json => uim.vibe.datatypes.jsons.typecheck.isArray(json)) 
    : indices.any!(index => jsons.isArray(index));
}
// #endregion any

// #region is
bool isArray(Json[] jsons, size_t index) {
  import uim.vibe.datatypes.jsons.typecheck;
  return jsons.length > index && uim.vibe.datatypes.jsons.typecheck.isArray(jsons[index]);
}
// #endregion is





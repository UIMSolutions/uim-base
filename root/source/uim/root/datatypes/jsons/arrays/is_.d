/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.arrays.is_;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

// #region all
bool isAllArray(Json[] jsons, size_t[] indices = null) {
  import uim.root.datatypes.jsons.typecheck;
  return (indices is null) 
    ? jsons.all!(json => uim.root.datatypes.jsons.typecheck.isArray(json)) 
    : indices.all!(index => jsons.isArray(index));
}
// #endregion all

// #region any
bool isAnyArray(Json[] jsons, size_t[] indices = null) {
  import uim.root.datatypes.jsons.typecheck;
  return (indices is null) 
    ? jsons.any!(json => uim.root.datatypes.jsons.typecheck.isArray(json)) 
    : indices.any!(index => jsons.isArray(index));
}
// #endregion any

// #region is
bool isArray(Json[] jsons, size_t index) {
  import uim.root.datatypes.jsons.typecheck;
  return jsons.length > index && uim.root.datatypes.jsons.typecheck.isArray(jsons[index]);
}
// #endregion is





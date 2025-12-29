/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.arrays.types.booleans.typecheck;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

// #region all
// #region noIndex
bool isAllBoolean(Json[] jsons) {
  return jsons.all!(json => isBoolean(json));
}
// #endregion noIndex

// #region index  
bool isAllBoolean(Json[] jsons, size_t[] indices) {
  return indices.all!(index => jsons.isBoolean(index));
}
// #endregion index
// #endregion all

// #region any
// #region noIndex
bool isAnyBoolean(Json[] jsons) {
  return jsons.any!(json => isBoolean(json));
}
// #endregion noIndex

// #region index
bool isAnyBoolean(Json[] jsons, size_t[] indices) {
  return indices.any!(index => jsons.isBoolean(index));
}
// #endregion index
// #endregion any

// #region is
bool isBoolean(Json[] jsons, size_t index) {
  if (index >= jsons.length) {
    return false;
  } 

  return isBoolean(jsons[index]);
}
// #endregion is
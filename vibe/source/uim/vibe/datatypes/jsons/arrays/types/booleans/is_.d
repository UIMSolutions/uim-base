/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.booleans.is_;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region all
// #region noIndex
bool isAllBoolean(Json[] values) {
  return values.all!(value => value.isBoolean);
}
// #endregion noIndex

// #region index  
bool isAllBoolean(Json[] values, size_t[] indices) {
  return indices.all!(index => values.isBoolean(index));
}
// #endregion index
// #endregion all

// #region any
// #region noIndex
bool isAnyBoolean(Json[] values) {
  return values.any!(value => value.isBoolean);
}
// #endregion noIndex

// #region index
bool isAnyBoolean(Json[] values, size_t[] indices) {
  return indices.any!(index => values.isBoolean(index));
}
// #endregion index
// #endregion any

// #region is
bool isBoolean(Json[] values, size_t index) {
  if (index >= values.length) {
    return false;
  } 

  return values[index].isBoolean;
}
// #endregion is
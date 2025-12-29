/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.doubles.is_;

import uim.vibe;
import uim.vibe.datatypes.jsons.json.types.doubles;

mixin(Version!("test_uim_vibe"));

@safe:

// #region all
// #region noIndex
bool isAllDouble(Json[] values) {
  return values.all!(value => uim.vibe.datatypes.jsons.typecheck.isDouble(value));
}
// #endregion noIndex

// #region index  
bool isAllDouble(Json[] values, size_t[] indices) {
  return indices.all!(index => values.isDouble(index));
}
// #endregion index
// #endregion all

// #region any
// #region noIndex
bool isAnyDouble(Json[] values) {
  return values.any!(value => uim.vibe.datatypes.jsons.typecheck.isDouble(value));
}
// #endregion noIndex

// #region index
bool isAnyDouble(Json[] values, size_t[] indices) {
  return indices.any!(index => values.isDouble(index));
}
// #endregion index
// #endregion any

// #region is
bool isDouble(Json[] values, size_t index) {
  if (index >= values.length) {
    return false;
  } 

  return uim.vibe.datatypes.jsons.typecheck.isDouble(values[index]);
}
// #endregion is
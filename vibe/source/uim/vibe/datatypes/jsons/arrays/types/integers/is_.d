/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.integers.is_;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region all
// #region noIndex
bool isAllInteger(Json[] values) {
  return values.all!(value => uim.vibe.datatypes.jsons.json.types.integers.is_.isInteger(value));
}
// #endregion noIndex

// #region index  
bool isAllInteger(Json[] values, size_t[] indices) {
  return indices.all!(index => values.isInteger(index));
}
// #endregion index
// #endregion all

// #region any
// #region noIndex
bool isAnyInteger(Json[] values) {
  return values.any!(value => uim.vibe.datatypes.jsons.json.types.integers.is_.isInteger(value));
}
// #endregion noIndex

// #region index
bool isAnyInteger(Json[] values, size_t[] indices) {
  return indices.any!(index => values.isInteger(index));
}
// #endregion index
// #endregion any

// #region is
bool isInteger(Json[] values, size_t index) {
  if (index >= values.length) {
    return false;
  } 

  return uim.vibe.datatypes.jsons.json.types.integers.is_.isInteger(values[index]);
}
// #endregion is
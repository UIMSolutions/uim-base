/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.string_;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region all
// #region noIndex
bool allString(Json[] values) {
  return values.all!(value => uim.vibe.datatypes.jsons.json.types.string_.isString(value));
}
// #region noIndex

// #region index
bool allString(Json[] values, size_t[] indices) {
  return indices.all!(index => values.isString(index));
}
// #endregion index
// #endregion all

// #region any
// #region noIndex
bool isAnyString(Json[] values) {
  return values.any!(value => uim.vibe.datatypes.jsons.json.types.string_.isString(value));
}
// #endregion noIndex

// #region index
bool isAnyString(Json[] values, size_t[] indices) {
  return indices.any!(index => values.isString(index));
}
// #endregion index
// #endregion any

// #region is
bool isString(Json[] values, size_t index) {
  if (index >= values.length) {
    return false;
  } 

  return uim.vibe.datatypes.jsons.json.types.string_.isString(values[index]);
}
// #endregion is
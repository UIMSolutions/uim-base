/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.nulls.is_;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region all
/**
  * Checks whether all specified indices in the given Json array are null.
  *
  * Params:
  *   values = The Json array to check.
  *   indices = The indices to check for null values.
  *
  * Returns:
  *   true if all specified indices are null, false otherwise.
  */
bool isAllNull(Json[] values, size_t[] indices) {
  return indices.all!(index => values.isNull(index));
}
// #endregion all

// #region any
/**
  * Checks whether any of the specified indices in the given Json array are null.
  *
  * Params:
  *   list = The Json array to check.
  *   indices = The indices to check for null values.
  *
  * Returns:
  *   true if any of the specified indices are null, false otherwise.
  */
bool isAnyNull(Json[] list, size_t[] indices) {
  return list.length == 0
    ? false
    : indices.any!(index => list.isNull(index));
}
// #endregion any

// #region is
/**
  * Checks whether the specified index in the given Json array is null.
  *
  * Params:
  *   values = The Json array to check.
  *   index = The index to check for a null value.
  *
  * Returns:
  *   true if the specified index is null, false otherwise.
  */
bool isNull(Json[] values, size_t index) {
  if (index >= values.length) {
    return false;
  } 

  return uim.vibe.datatypes.jsons.typecheck.isNull(values[index]);
}
// #endregion is

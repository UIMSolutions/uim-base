/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.arrays.types.nulls.is_;

import uim.root;

mixin(Version!("show_uim_root"));

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
  return values.length > index ? values[index] == Json(null) : false;
}
// #endregion is

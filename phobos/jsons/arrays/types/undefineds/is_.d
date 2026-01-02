/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.arrays.types.undefineds.is_;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

/** 
  * Checks if all values in the given JSON array are of type `undefined`.
  *
  * Params:
  *   values = The JSON array to check.
  *
  * Returns:
  *   `true` if all values are `undefined`, `false` otherwise.
  */
bool isAllUndefined(Json[] values) {
  return values.all!(value => uim.root.datatypes.jsons.typecheck.isUndefined(value));
}

/** 
  * Checks if all values at the specified indices in the given JSON array are of type `undefined`.
  *
  * Params:
  *   values = The JSON array to check.
  *   indices = The indices of the values to check.
  *
  * Returns:
  *   `true` if all specified values are `undefined`, `false` otherwise.
  */
bool isAllUndefined(Json[] values, size_t[] indices) {
  return indices.all!(index => values.isUndefined(index));
}

bool isAnyUndefined(Json[] values) {
  return values.any!(value => uim.root.datatypes.jsons.typecheck.isUndefined(value));
}

bool isAnyUndefined(Json[] values, size_t[] indices) {
  return indices.any!(index => values.isUndefined(index));
}

bool isUndefined(Json[] values, size_t index) {
  if (index >= values.length) {
    return false;
  } 

  return uim.root.datatypes.jsons.typecheck.isUndefined(values[index]);
}

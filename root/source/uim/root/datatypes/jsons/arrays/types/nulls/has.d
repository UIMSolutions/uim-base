/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.nulls.has;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

/**
  * Checks whether all elements in the given Json array are null.
  *
  * Params:
  *   values = The Json array to check.
  *
  * Returns:
  *   true if all elements are null, false otherwise.
  */
bool hasOnlyNull(Json[] values) {
  return values.all!(value => value == Json(null));
}

/**
  * Checks whether any element in the given Json array is null.
  *
  * Params:
  *   values = The Json array to check.
  *
  * Returns:
  *   true if any element is null, false otherwise.
  */
bool hasNull(Json[] values) {
  return values.any!(value => value == Json(null));
}
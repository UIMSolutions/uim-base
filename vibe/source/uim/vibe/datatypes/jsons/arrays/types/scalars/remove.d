/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.scalars.remove;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

/**
  * Removes scalar Json values from the given array based on a provided function.
  *
  * Params:
  *   jsons = The array of Json values to process.
  *   removeFunc = A delegate function that determines which scalar Json values to remove.
  *
  * Returns:
  *   A new array of Json values with the specified scalar values removed.
  */
Json[] removeScalars(Json[] jsons, bool delegate(Json json) @safe removeFunc) {
  return jsons.removeScalars.removeValues(removeFunc);
}

Json[] removeScalars(Json[] jsons, size_t[] indices) {
  return jsons.removeIndices(indices).removeScalars;
}

Json[] removeScalars(Json[] jsons) {
  return jsons.filter!(json => !json.isScalar).array;
}

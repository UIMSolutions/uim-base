/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.arrays.types.scalars.remove;

import uim.root;

mixin(Version!("show_uim_root"));

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
  return jsons.filter!(json => !foundScalar(json, removeFunc)).array;
}

Json[] removeScalars(Json[] jsons, size_t[] indices) {
  return jsons.removeValues(indices).removeScalars;
}

Json[] removeScalars(Json[] jsons) {
  return jsons.filter!(json => !json.isScalar).array;
}

/** 
  * Helper function to determine if a Json value is a scalar and matches the removal criteria.
  *
  * Params:
  *   json = The Json value to check.
  *   removeFunc = A delegate function that defines the removal criteria for scalar values.
  *
  * Returns:
  *   `true` if the Json value is a scalar and matches the removal criteria; otherwise, `false`.
  */
protected bool foundScalar(Json json, bool delegate(Json json) @safe removeFunc) {
  return json.isScalar && removeFunc(json);
}

protected bool foundScalar(Json json, bool delegate(Json json) removeFunc) {
  bool found = false;
  () @trusted { found = json.isScalar && removeFunc(json); }();
  return found;
}

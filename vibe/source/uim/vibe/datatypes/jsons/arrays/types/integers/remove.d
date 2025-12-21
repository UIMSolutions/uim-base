/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.integers.remove;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

/** 
  * Remove integer Json values from the provided Json array based on a delegate function.
  *
  * Params:
  *   jsons = The Json array to remove integer values from.
  *   removeFunc = A delegate function that determines whether a given integer Json value should be removed.
  *
  * Returns:
  *   A new Json array with the specified integer values removed.
  */
Json[] removeIntegers(Json[] jsons, bool delegate(Json json) removeFunc) {
  return jsons.filter!(json => !foundInteger(json, removeFunc)).array;
}

Json[] removeIntegers(Json[] jsons, size_t[] indices) {
  return jsons.removeValues(indices).removeIntegers;
}

Json[] removeIntegers(Json[] jsons) {
  return jsons.filter!(json => !json.isInteger).array;
}

protected bool foundInteger(Json json, bool delegate(Json value) removeFunc) {
  bool found = false;
  () @trusted { found = json.isInteger && json.removeFunc; }();
  return found;
}
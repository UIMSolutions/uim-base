/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.arrays.types.booleans.remove;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

/**
  * Remove boolean Json values from the specified Json array based on a delegate function.
  *
  * Params:
  *   jsons = The Json array to remove boolean values from.
  *   removeFunc = A delegate function that determines whether a boolean Json value should be removed.
  *
  * Returns:
  *   A new Json array with the specified boolean values removed.
  */
Json[] removeBooleans(Json[] jsons, bool delegate(Json json) removeFunc) {
  return jsons.filter!(json => !foundBoolean(json, removeFunc)).array;
}

Json[] removeBooleans(Json[] jsons, size_t[] indices) {
  return removeValues(jsons, indices).removeBooleans.array;
}

Json[] removeBooleans(Json[] jsons) {
  return jsons.filter!(json => !json.isBoolean).array;
}

protected bool foundBoolean(Json json, bool delegate(Json value) removeFunc) {
  bool found = false;
  () @trusted { found = json.isBoolean && removeFunc(json); }();
  return found;
}
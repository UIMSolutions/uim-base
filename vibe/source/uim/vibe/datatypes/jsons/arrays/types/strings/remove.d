/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.strings.remove;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

/** 
  * Remove strings from the specified Json array based on a delegate function.
  *
  * Params:
  *   jsons = The Json array to remove strings from.
  *   removeFunc = A delegate function that determines whether a string should be removed.
  *
  * Returns:
  *   A new Json array with the specified strings removed.
  */
Json[] removeStrings(Json[] jsons, bool delegate(Json json) removeFunc) {
  return jsons.filter!(json => !foundString(json, removeFunc)).array;
}

Json[] removeStrings(Json[] jsons, size_t[] indices) {
  return jsons.removeValues(indices).removeStrings;
}

Json[] removeStrings(Json[] jsons) {
  return jsons.filter!(json => !json.isString).array;
}

protected bool foundString(Json json, bool delegate(Json value) @safe removeFunc) {
  return json.isString && removeFunc(json);
}
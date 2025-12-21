/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.booleans.remove;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

Json[] removeBooleans(Json[] jsons, bool delegate(Json json) removeFunc) {
  return jsons.filter!(json => !foundBoolean(json, removeFunc)).array;
}

Json[] removeBooleans(Json[] jsons, size_t[] indices) {
  return jsons.removeIndices(indices).removeBooleans.array;
}

Json[] removeBooleans(Json[] jsons) {
  return jsons.filter!(json => !json.isBoolean).array;
}

protected bool foundBoolean(Json json, bool delegate(Json value) removeFunc) {
  bool found = false;
  () @trusted { found = json.isBoolean && json.removeFunc; }();
  return found;
}
/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.json.types.undefineds.remove;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

Json[] removeUndefineds(Json[] jsons, bool delegate(Json json) @safe removeFunc) {
  return jsons.removeUndefineds.removeValues(removeFunc);
}

Json[] removeUndefineds(Json[] jsons, size_t[] indices) {
  return jsons.removeIndices(indices).removeUndefineds.array;
}

Json[] removeUndefineds(Json[] jsons) {
  return jsons.filter!(json => !json.isUndefined).array;
}
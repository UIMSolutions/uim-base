/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.strings copy.remove;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

Json[] removeStrings(Json[] jsons, bool delegate(Json json) @safe removeFunc) {
  return jsons.removeStrings.removeValues(removeFunc);
}

Json[] removeStrings(Json[] jsons, size_t[] indices) {
  return jsons.removeIndices(indices).removeStrings;
}

Json[] removeStrings(Json[] jsons) {
  return jsons.filter!(json => !json.isString).array;
}

/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.scalars.remove;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

Json[] removeScalars(Json[] jsons, bool delegate(Json json) @safe removeFunc) {
  return jsons.removeScalars.removeValues(removeFunc);
}

Json[] removeScalars(Json[] jsons, size_t[] indices) {
  return jsons.removeIndices(indices).removeScalars;
}

Json[] removeScalars(Json[] jsons) {
  return jsons.filter!(json => !json.isScalar).array;
}

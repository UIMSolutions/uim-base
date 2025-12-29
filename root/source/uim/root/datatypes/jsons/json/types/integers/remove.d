/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.json.types.integers.remove;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

Json[] removeIntegers(Json[] jsons, bool delegate(Json json) @safe removeFunc) {
  return jsons.removeIntegers.removeValues(removeFunc);
}

Json[] removeIntegers(Json[] jsons, size_t[] indices) {
  return jsons.removeValues(indices).removeIntegers.array;
}

Json[] removeIntegers(Json[] jsons) {
  return jsons.filter!(json => !json.isInteger).array;
}
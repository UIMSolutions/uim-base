/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.doubles.remove;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

Json[] removeDoubles(Json[] items, bool delegate(Json json) @safe removeFunc) {
  return items.removeDoubles.removeValues(removeFunc);
}

Json[] removeDoubles(Json[] items, size_t[] indices) {
  return items.removeIndices(indices).removeDoubles;
}

Json[] removeDoubles(Json[] items) {
  return items.filter!(item => !item.isDouble).array;
}

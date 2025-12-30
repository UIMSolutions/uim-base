/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.types.arrays.remove;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

Json[] removeArrays(Json[] jsons, bool delegate(Json json) @safe removeFunc) {
  return jsons.removeArrays.removeValues(removeFunc);
}

Json[] removeArrays(Json[] jsons, size_t[] indices) {
  return jsons.removeValues(indices).removeArrays.array;
}

Json[] removeArrays(Json[] jsons) {
  return jsons.filter!(json => !json.isArray).array;
}
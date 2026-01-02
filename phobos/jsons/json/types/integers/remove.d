/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.types.integers.remove;

import uim.root;

mixin(Version!("show_uim_root"));

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
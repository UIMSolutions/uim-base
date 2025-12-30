/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.types.booleans.remove;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

Json[] removeBooleans(Json[] jsons, bool delegate(Json json) @safe removeFunc) {
  return jsons.removeBooleans.removeValues(removeFunc);
}

Json[] removeBooleans(Json[] jsons, size_t[] indices) {
  return jsons.removeValues(indices).removeBooleans.array;
}

Json[] removeBooleans(Json[] jsons) {
  return jsons.filter!(json => !json.isBoolean).array;
}
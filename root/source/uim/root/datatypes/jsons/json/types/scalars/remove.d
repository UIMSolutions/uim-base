/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.types.scalars.remove;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

Json[] removeScalars(Json[] jsons, bool delegate(Json json) @safe removeFunc) {
  return jsons.removeScalars.removeValues(removeFunc);
}

Json[] removeScalars(Json[] jsons, size_t[] indices) {
  return jsons.removeValues(indices).removeScalars.array;
}

Json[] removeScalars(Json[] jsons) {
  return jsons.filter!(json => !json.isScalar).array;
}
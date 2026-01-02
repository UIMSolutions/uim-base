/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.types.nulls.remove;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

Json[] removeNulls(Json[] jsons, bool delegate(Json json) @safe removeFunc) {
  return jsons.removeNulls.removeValues(removeFunc);
}

Json[] removeNulls(Json[] jsons, size_t[] indices) {
  return jsons.removeValues(indices).removeNulls.array;
}

Json[] removeNulls(Json[] jsons) {
  return jsons.filter!(json => !json.isNull).array;
}
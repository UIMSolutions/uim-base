/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.values;

import uim.root;
mixin(Version!("show_uim_root"));

@safe:

Json[] values(Json json, Json delegate(Json json) @safe mapFunc) {
  return json.values.map!(j => mapFunc(j));
}

Json[] values(Json json) {
  if (json.isArray || json.isObject) {
    return json.byValue.array;
  }
  return null;
}

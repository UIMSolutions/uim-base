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
  return json.isArray || json.isObject ? json.byValue.array.map!(j => mapFunc(j)).array : null;
}

Json[] values(Json json) {
  return json.isArray || json.isObject ? json.byValue.array : null;
}

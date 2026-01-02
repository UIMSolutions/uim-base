/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.arrays.types.strings.convert;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

string[] toStrings(Json[] jsons, string delegate(Json json) @safe convertFunc) {
  return jsons.map!(json => convertFunc(json)).array;
}

string[] toStrings(Json[] jsons, size_t[] indices) {
  return jsons.filterValues(indices).toStrings;
}

string[] toStrings(Json[] jsons) {
  return jsons.map!(json => json.toString).array;
}

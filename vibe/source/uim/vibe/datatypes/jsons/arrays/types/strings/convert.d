/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.strings.convert;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

int[] toStrings(Json[] jsons, int delegate(Json json) @safe convertFunc) {
  return jsons.map!(json => convertFunc(json)).array;
}

int[] toStrings(Json[] jsons, size_t[] indices) {
  return jsons.filterStrings(indices).toStrings;
}

int[] toStrings(Json[] jsons) {
  return jsons.filterStrings.map!(json => json.toInteger).array;
}

/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.booleans.convert;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

int[] toBooleans(Json[] jsons, int delegate(Json json) @safe convertFunc) {
  return jsons.map!(json => convertFunc(json)).array;
}

int[] toBooleans(Json[] jsons, size_t[] indices) {
  return jsons.filterBooleans(indices).toBooleans;
}

int[] toBooleans(Json[] jsons) {
  return jsons.filterBooleans.map!(json => json.toInteger).array;
}

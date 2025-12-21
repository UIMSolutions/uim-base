/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.booleans.convert;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

bool[] toBooleans(Json[] jsons, bool delegate(Json json) @safe convertFunc) {
  return jsons.map!(json => convertFunc(json)).array;
}

bool[] toBooleans(Json[] jsons, size_t[] indices) {
  import uim.vibe.datatypes.jsons.arrays.types.booleans.filter;
  return jsons.filterBooleans(indices).toBooleans;
}

bool[] toBooleans(Json[] jsons) {
  return jsons.filterBooleans.map!(json => json.toBoolean).array;
}

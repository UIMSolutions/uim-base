/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.doubles.convert;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

double[] toDoubles(Json[] jsons, double delegate(Json json) @safe convertFunc) {
  return jsons.map!(json => convertFunc(json)).array;
}

double[] toDoubles(Json[] jsons, size_t[] indices) {
  import uim.vibe.datatypes.jsons.arrays.types.doubles.filter;
  return filterDoubles(jsons, indices).toDoubles;
}

double[] toDoubles(Json[] jsons) {
  import uim.vibe.datatypes.jsons.arrays.types.doubles.filter;
  return filterDoubles(jsons).map!(json => json.toDouble).array;
}

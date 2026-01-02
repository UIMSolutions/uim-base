/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.arrays.types.doubles.convert;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

double[] toDoubles(Json[] jsons, double delegate(Json json) @safe convertFunc) {
  return jsons.map!(json => convertFunc(json)).array;
}

double[] toDoubles(Json[] jsons, size_t[] indices) {
  import uim.root.datatypes.jsons.arrays.types.doubles.filter;
  return filterDoubles(jsons, indices).toDoubles;
}

double[] toDoubles(Json[] jsons) {
  import uim.root.datatypes.jsons.arrays.types.doubles.filter;
  return filterDoubles(jsons).map!(json => json.toDouble).array;
}

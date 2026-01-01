/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.arrays.types.booleans.convert;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

bool[] toBooleans(Json[] jsons, bool delegate(Json json) @safe convertFunc) {
  return jsons.map!(json => convertFunc(json)).array;
}

bool[] toBooleans(Json[] jsons, size_t[] indices) {
  import uim.root.datatypes.jsons.arrays.types.booleans.filter;
  return jsons.filterBooleans(indices).toBooleans;
}

bool[] toBooleans(Json[] jsons) {
  import uim.root.datatypes.jsons.arrays.types.booleans.filter;
  return jsons.filterBooleans.map!(json => json.toBoolean).array;
}
///
unittest {
  import uim.root.datatypes.jsons.json;
  import uim.root.datatypes.jsons.arrays.types.booleans.convert : toBooleans;
  
  Json[] jsons = [ Json(true), Json(1), Json(false), Json("true"), Json(null) ];
  
  auto bools1 = toBooleans(jsons, json => json.toBoolean);
  assert(bools1 == [ true, true, false, true, false ]);
  
  import uim.root.datatypes.jsons.arrays.types.booleans.filter : filterBooleans;
  auto bools2 = toBooleans(jsons.filterBooleans);
  assert(bools2 == [ true, false ]);
}
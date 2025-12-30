/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.types.doubles.first;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

Json firstBoolean(Json[] jsons) {
  import uim.root.datatypes.jsons.arrays.types.booleans.filter;
  return jsons.filterBooleans.first;
}


/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.arrays.types.booleans.first;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

Json firstBoolean(Json[] jsons) {
  import uim.root.datatypes.jsons.arrays.types.booleans.filter;
  return filterBooleans(jsons).first;
}


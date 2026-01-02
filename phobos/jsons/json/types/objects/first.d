/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.types.objects.first;

import uim.root;
  import uim.root.datatypes.jsons.arrays.types.booleans.filter;

mixin(Version!("show_uim_root"));

@safe:

Json firstBoolean(Json[] jsons) {
  return jsons.filterBooleans.first;
}


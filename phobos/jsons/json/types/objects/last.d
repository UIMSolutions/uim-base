/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.types.objects.last;

import uim.root;
  import uim.root.datatypes.jsons.arrays.types.booleans.filter;

mixin(Version!("show_uim_root"));

@safe:

Json lastBoolean(Json json) {
  if (!json.isArray) {
    return Json(null);
  }
  return json.toArray.filterBooleans.last;
}

Json lastBoolean(Json[] jsons) {
  return jsons.filterBooleans.last;
}



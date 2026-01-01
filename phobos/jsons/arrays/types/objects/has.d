/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.arrays.types.objects.has;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

bool hasOnlyObject(Json[] jsons) {
  return jsons.all!(json => isObject(json));
}

bool hasObject(Json[] jsons) {
  return jsons.any!(json => isObject(json));
}

/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.arrays.types.strings.has;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

bool hasOnlyString(Json[] jsons) {
  return jsons.all!(json => isString(json));
}

bool hasString(Json[] jsons) {
  return jsons.any!(json => isString(json));
}

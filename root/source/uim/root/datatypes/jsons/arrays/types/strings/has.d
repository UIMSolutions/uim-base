/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.strings.has;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

bool hasOnlyString(Json[] jsons) {
  return jsons.all!(json => isString(json));
}

bool hasString(Json[] jsons) {
  return jsons.any!(json => isString(json));
}

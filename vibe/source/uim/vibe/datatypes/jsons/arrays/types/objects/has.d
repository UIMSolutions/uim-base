/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.objects.has;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

bool hasOnlyObject(Json[] jsons) {
  return jsons.all!(json => isObject(json));
}

bool hasObject(Json[] jsons) {
  return jsons.any!(json => isObject(json));
}

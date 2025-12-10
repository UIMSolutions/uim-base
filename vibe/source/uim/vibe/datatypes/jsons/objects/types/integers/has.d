/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.objects.types.integers.has;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

bool hasInteger(Json[string] obj) {
  return obj.byValue.any!(v => v.isInteger);
}
/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.json.types.strings.first;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

Json firstBoolean(Json[] jsons) {
  return jsons.filterBooleans.first;
}


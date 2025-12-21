/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.booleans.get;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

bool getBoolean(Json[] jsons, size_t index, bool defaultValue = false) {
  import uim.vibe.datatypes.jsons.json.get;
  return jsons.length > index && jsons[index].isBoolean ? uim.vibe.datatypes.jsons.json.get.getBoolean(jsons[index], defaultValue) : defaultValue;
}
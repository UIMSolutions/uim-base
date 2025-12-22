/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.doubles.get;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

double getDouble(Json[] jsons, size_t index, double defaultValue = 0.0) {
  import uim.vibe.datatypes.jsons.json.get;

  return jsons.length > index && jsons[index].isDouble
    ? uim.vibe.datatypes.jsons.json.get.getDouble(jsons[index], defaultValue) : defaultValue;
}

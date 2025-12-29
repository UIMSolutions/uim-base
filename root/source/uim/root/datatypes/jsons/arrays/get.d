/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.get;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

Json[] getArrayByIndex(Json[] jsons, size_t index, Json[] defaultValue = null) {
  return jsons.length > index && jsons[index].isArray ? jsons[index].get!(Json[]) : defaultValue;
}
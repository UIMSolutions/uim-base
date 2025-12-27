/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.first;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

Json firstArray(Json[] jsons) {
  import uim.vibe.datatypes.jsons.arrays.filter;
  return jsons.filterArrays.first;
}



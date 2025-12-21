/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.last;

import uim.vibe;
import uim.vibe.datatypes.jsons.arrays.filter;
mixin(Version!("test_uim_vibe"));

@safe:

Json lastArray(Json[] jsons) {
  return uim.vibe.datatypes.jsons.arrays.filter.filterArrays(jsons).last;
}

Json lastInteger(Json[] jsons) {
  import uim.vibe.datatypes.jsons.arrays.types.integers.filter;
  return filterIntegers(jsons).last;
}

Json lastScalar(Json[] jsons) {
  import uim.vibe.datatypes.jsons.arrays.types.integers.filter;
  return filterScalars(jsons).last;
}



/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.last;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

Json lastArray(Json[] jsons) {
  return uim.vibe.datatypes.jsons.arrays.filter.filterArrays(jsons).last;
}

Json lastBoolean(Json[] jsons) {
  return uim.vibe.datatypes.jsons.arrays.types.booleans.filter.filterBooleans(jsons).last;
}

Json lastInteger(Json[] jsons) {
  return uim.vibe.datatypes.jsons.arrays.types.integers.filter.filterIntegers(jsons).last;
}

Json lastDouble(Json[] jsons) {
  return uim.vibe.datatypes.jsons.arrays.types.doubles.filter.filterDoubles(jsons).last;
}

Json lastString(Json[] jsons) {
  return uim.vibe.datatypes.jsons.arrays.types.strings.filter.filterStrings(jsons).last;
}

Json lastScalar(Json[] jsons) {
  return uim.vibe.datatypes.jsons.arrays.types.scalarsfilter.filterScalars(jsons).last;
}

Json last(Json[] jsons) {
  return jsons.length > 0 ? jsons[$ - 1] : Json(null);
}

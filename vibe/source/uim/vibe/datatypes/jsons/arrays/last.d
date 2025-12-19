/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.last;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region Object
Json lastObject(Json[] jsons) {
  return jsons.filterObjects.last;
}

Json lastWithAllKey(Json[] jsons, string[] keys) {
  return jsons.filterObjectWithAllKey(keys).last;
}

Json lastWithAnyKey(Json[] jsons, string[] keys) {
  return jsons.filterObjectWithAnyKey(keys).last;
}

Json lastWithKey(Json[] jsons, string key) {
  return jsons.filterObjectWithKey(key).last;
}
// #endregion Object

Json lastArray(Json[] jsons) {
  return jsons.filterArrays.last;
}

Json lastBoolean(Json[] jsons) {
  return jsons.filterArrays.last;
}

Json lastInteger(Json[] jsons) {
  return jsons.filterIntegers.last;
}

Json lastDouble(Json[] jsons) {
  return jsons.filterDoubles.last;
}

Json lastString(Json[] jsons) {
  return jsons.filterStrings.last;
}

Json lastScalar(Json[] jsons) {
  return jsons.filterScalars.last;
}

Json last(Json[] jsons) {
  return jsons.length > 0 ? jsons[$ - 1] : Json(null);
}

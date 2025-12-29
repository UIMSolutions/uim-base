/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.last;

import uim.root;
import uim.root.containers.sequential.arrays.last;
  import uim.root.datatypes.jsons.arrays.types.doubles.filter;

mixin(Version!("test_uim_root"));

@safe:

Json last(Json json) {
  return json.isArray
    ? uim.root.containers.sequential.arrays.last.last(json.toArray) : Json(null);
}

Json lastObject(Json json) {
  import uim.root.datatypes.jsons.arrays.types.objects.filter;

  return json.isArray
    ? uim.root.containers.sequential.arrays.last.last(json.toArray.filterObjects) : Json(null);
}

Json lastArray(Json json) {
  import uim.root.datatypes.jsons.arrays.filter;

  return json.isArray
    ? uim.root.containers.sequential.arrays.last.last(json.toArray.filterArrays) : Json(null);
}

Json lastScalar(Json json) {
  import uim.root.datatypes.jsons.arrays.types.scalars.filter;

  return json.isArray
    ? uim.root.containers.sequential.arrays.last.last(
      json.toArray.filterScalars) : Json(null);
}

Json lastBoolean(Json json) {
  import uim.root.datatypes.jsons.arrays.types.booleans.filter;

  return json.isArray
    ? uim.root.containers.sequential.arrays.last.last(
      json.toArray.filterBooleans) : Json(null);
}

Json lastInteger(Json json) {
  import uim.root.datatypes.jsons.arrays.types.integers.filter;

  return json.isArray
    ? uim.root.containers.sequential.arrays.last.last(
      json.toArray.filterIntegers) : Json(null);
}

Json lastDouble(Json json) {
  import uim.root.datatypes.jsons.arrays.types.doubles.filter;

  return json.isArray
    ? uim.root.containers.sequential.arrays.last.last(
      json.toArray.filterDoubles) : Json(null);
}

Json lastString(Json json) {
  import uim.root.datatypes.jsons.arrays.types.strings.filter;

  return json.isArray
    ? uim.root.containers.sequential.arrays.last.last(
      json.toArray.filterStrings) : Json(null);
}

/* 
Json lastWithAllKey(Json json, string[] keys) {
  return json.isArray
    ? last(json.toArray.filterHasAllKey(keys)) : Json(null);
}

Json lastWithAnyKey(Json json, string[] keys) {
  return json.isArray
    ? last(json.toArray.filterHasAnyKey(keys)) : Json(null);
}

Json lastHasKey(Json json, string key) {
  return json.isArray
    ? last(json.toArray.filterHasKey(key)) : Json(null);
}
*/

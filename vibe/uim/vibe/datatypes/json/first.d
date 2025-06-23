/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.datatypes.json.first;

mixin(Version!("test_uim_vibe"));

import uim.vibe;

@safe:

// #region Json[]
Json firstObject(Json[] items) {
  return items.filterObject.first;
}

Json firstNotObject(Json[] items) {
  return items.filterNotObject.first;
}

Json firstHasKey(Json[] items, string key) {
  return items.filterHasKey(key).first;
}

Json firstWithoutKey(Json[] items, string key) {
  return items.filterWithoutKey(key).first;
}

unittest {
  // Prepare test data
  Json obj1 = ["a": 1, "b": 2].toJson;
  Json obj2 = ["x": 10].toJson;
  Json arr1 = [1, 2, 3].toJson;
  Json str1 = "hello".toJson;
  Json num1 = 42.toJson;

  Json[] items = [obj1, arr1, str1, obj2, num1];

  // Test firstObject
  assert(firstObject(items) == obj1);

  // Test firstNotObject
  assert(firstNotObject(items) == arr1);

  // Test firstHasKey
  assert(firstHasKey(items, "x") == obj2);
  assert(firstHasKey(items, "a") == obj1);

  // Test firstWithoutKey
  assert(firstWithoutKey(items, "a") == obj2);

  // Test with empty array
  Json[] emptyItems;
  assert(firstObject(emptyItems).isNull);
  assert(firstNotObject(emptyItems).isNull);
  assert(firstHasKey(emptyItems, "any").isNull);
  assert(firstWithoutKey(emptyItems, "any").isNull);

  // Test with no matching object
  Json[] onlyArrays = [arr1, str1, num1];
  assert(firstObject(onlyArrays).isNull);
  assert(firstHasKey(onlyArrays, "z").isNull);

  // Test with all objects
  Json[] onlyObjects = [obj1, obj2];
  assert(firstNotObject(onlyObjects).isNull);
  assert(firstWithoutKey(onlyObjects, "a") == obj2);
}
// #endregion Json[]

// #region Json
Json firstObject(Json json) {
  return json.isArray
    ? json.toArray.filterObject.first : Null!Json;
}

Json firstNotObject(Json json) {
  return json.isArray
    ? json.toArray.filterNotObject.first : Null!Json;
}

Json firstHasKey(Json json, string key) {
  return json.isArray
    ? json.toArray.filterHasKey(key).first : Null!Json;
}

Json firstWithoutKey(Json json, string key) {
  return json.isArray
    ? json.toArray.filterWithoutKey(key).first : Null!Json;
}
// #endregion Json

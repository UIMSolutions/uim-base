/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.datatypes.json.filter;

mixin(Version!("test_uim_vibe"));

import uim.vibe;

@safe:

Json[] filterObject(Json[] items) {
  return items.filter!(item => item.isObject).array;
}

Json[] filterNotObject(Json[] items) {
  return items.filter!(item => !item.isObject).array;
}

Json[] filterHasKey(Json[] items, string key) {
  return items.filterObject.filter!(item => item.hasKey(key)).array;
}

Json[] filterWithoutKey(Json[] items, string key) {
  return items.filterObject.filter!(item => !item.hasKey(key)).array;
}

unittest {
  // Prepare test data
  Json obj1 = ["a": 1, "b": 2].toJson;
  Json obj2 = ["b": 3].toJson;
  Json arr = Json([1, 2, 3]);
  Json str = Json("hello");
  Json num = Json(42);
  Json nullVal = Json(null);

  Json[] items = [obj1, arr, str, obj2, num, nullVal];

  // Test filterObject
  auto objects = filterObject(items);
  assert(objects.length == 2);
  assert(objects[0] == obj1);
  assert(objects[1] == obj2);

  // Test filterNotObject
  auto notObjects = filterNotObject(items);
  assert(notObjects.length == 4);
  assert(notObjects[0] == arr);
  assert(notObjects[1] == str);
  assert(notObjects[2] == num);
  assert(notObjects[3] == nullVal);

  // Test filterHasKey
  auto hasA = filterHasKey(items, "a");
  assert(hasA.length == 1);
  assert(hasA[0] == obj1);

  auto hasB = filterHasKey(items, "b");
  assert(hasB.length == 2);
  assert(hasB[0] == obj1);
  assert(hasB[1] == obj2);

  // Test filterWithoutKey
  auto withoutA = filterWithoutKey(items, "a");
  assert(withoutA.length == 1);
  assert(withoutA[0] == obj2);

  auto withoutB = filterWithoutKey(items, "b");
  assert(withoutB.length == 0);
}

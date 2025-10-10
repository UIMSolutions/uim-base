/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.json.filter;

import uim.vibe;

mixin(Version!("test_uim_vibe"));
@safe:

// #region Json[]
// #region Filter by type
// Filter Json array by objects
Json[] filterObjects(Json[] items) {
  return items.filter!(item => item.isObject).array;
}

// Filter Json array by arrays
Json[] filterArrays(Json[] items) {
  return items.filter!(item => item.isArray).array;
}

// Filter Json array by values
Json[] filterValues(Json[] items) {
  return items.filter!(item => !item.isArray & !item.isObject).array;
}

unittest {
  // Prepare test data
  Json obj1 = ["a": 1, "b": 2].toJson;
  Json obj2 = ["b": 3].toJson;
  Json arr = [1, 2, 3].toJson;
  Json str = Json("hello");
  Json num = Json(42);
  Json nullVal = Json(null);

  Json[] items = [obj1, arr, str, obj2, num, nullVal];

  // Test filterObjects
  auto objects = filterObjects(items);
  assert(objects.length == 2, "filterObjects should return 2 objects");
  assert(objects[0] == obj1, "First object should be obj1");
  assert(objects[1] == obj2, "Second object should be obj2");

  // Test filterArrays
  auto arrays = filterArrays(items);
  writeln("array.length: ", arrays.length);
  assert(arrays.length == 1, "filterArrays should return 1 array");
  assert(arrays[0] == arr, "Array should be arr");

  // Test filterValues
  auto values = filterValues(items);
  assert(values.length == 3, "filterValues should return 3 values");
  assert(values[0] == str, "First value should be str");
  assert(values[1] == num, "Second value should be num");
  assert(values[2] == nullVal, "Third value should be nullVal");
}
// #endregion Filter by type

// #region Filter by key
Json[] filterHasAllKeys(Json[] items, string[] keys) {
  return items.filterObjects.filter!(item => item.hasAllKeys(keys)).array;
}

Json[] filterHasAnyKey(Json[] items, string[] keys) {
  return items.filterObjects.filter!(item => item.hasAnyKey(keys)).array;
}

Json[] filterHasKey(Json[] items, string key) {
  return items.filterObjects.filter!(item => item.hasKey(key)).array;
}
// #endregion Filter by key


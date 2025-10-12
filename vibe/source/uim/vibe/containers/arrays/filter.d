/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.containers.arrays.filter;

import uim.vibe;

mixin(Version!("test_uim_vibe"));
@safe:

// #region filterObjects
Json[] filterObjects(Json[] items) {
  return items.filter!(item => item.isObject).array;
}
///
unittest {
  // Test: filterObjects returns only objects from mixed Json array

  // Prepare test data
  Json object1 = ["x": 1, "y": 2].toJson;
  Json object2 = ["z": 3].toJson;
  Json arr = [1, 2, 3].toJson;
  Json str = Json("test");
  Json num = Json(123);
  Json nullVal = Json(null);

  Json[] items = [object1, arr, str, object2, num, nullVal];

  auto result = filterObjects(items);

  assert(result.length == 2, "Should return 2 objects");
  assert(result[0] == object1, "First object should be object1");
  assert(result[1] == object2, "Second object should be object2");

  // Test: filterObjects with no objects
  Json[] noObjects = [arr, str, num, nullVal];
  auto emptyResult = filterObjects(noObjects);
  assert(emptyResult.length == 0, "Should return empty array when no objects");

  // Test: filterObjects with all objects
  Json[] allObjects = [object1, object2];
  auto allResult = filterObjects(allObjects);
  assert(allResult.length == 2, "Should return all objects");
  assert(allResult[0] == object1);
  assert(allResult[1] == object2);
}
// #endregion filterObjects


Json[] filterArrays(Json[] items) {
  return items.filter!(item => item.isArray).array;
}
/// 
unittest {
  // Test: filterArrays returns only arrays from mixed Json array

  // Prepare test data
  Json object1 = ["x": 1, "y": 2].toJson;
  Json object2 = ["z": 3].toJson;
  Json array1 = [1, 2, 3].toJson;
  Json array2 = ["a", "b", "c"].toJson;
  Json str = Json("test");
  Json num = Json(123);
  Json nullVal = Json(null);

  Json[] items = [object1, array1, str, object2, num, array2, nullVal];

  auto result = filterArrays(items);

  assert(result.length == 2, "Should return 2 arrays");
  assert(result[0] == array1, "First array should be array1");
  assert(result[1] == array2, "Second array should be array2");

  // Test: filterArrays with no arrays
  Json[] noArrays = [object1, object2, str, num, nullVal];
  auto emptyResult = filterArrays(noArrays);
  assert(emptyResult.length == 0, "Should return empty array when no arrays");

  // Test: filterArrays with all arrays
  Json[] allArrays = [array1, array2];
  auto allResult = filterArrays(allArrays);
  assert(allResult.length == 2, "Should return all arrays");
  assert(allResult[0] == array1);
  assert(allResult[1] == array2);
}

Json[] filterValues(Json[] items) {
  return items.filter!(item => !item.isArray & !item.isObject)
    .filter!(item => !item.isNull).array;
}

unittest {
  // Prepare test data
  Json object1 = ["a": 1, "b": 2].toJson;
  Json object2 = ["b": 3].toJson;
  Json arr = [1, 2, 3].toJson;
  Json str = Json("hello");
  Json num = Json(42);
  Json nullVal = Json(null);

  Json[] items = [object1, arr, str, object2, num, nullVal];

  // Test filterObjects
  auto objects = filterObjects(items);
  assert(objects.length == 2, "filterObjects should return 2 objects");
  assert(objects[0] == object1, "First object should be object1");
  assert(objects[1] == object2, "Second object should be object2");

  // Test filterArrays
  auto arrays = filterArrays(items);
  writeln("array.length: ", arrays.length);
  assert(arrays.length == 1, "filterArrays should return 1 array");
  assert(arrays[0] == arr, "Array should be arr");

  // Test filterValues
  auto values = filterValues(items);
  assert(values.length == 2, "filterValues should return 2 values");
  assert(values[0] == str, "First value should be str");
  assert(values[1] == num, "Second value should be num");
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

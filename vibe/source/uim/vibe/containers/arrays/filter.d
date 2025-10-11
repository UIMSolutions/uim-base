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
/**
 * Recursively filters and returns an array of `Json` objects from the given `Json` input.
 *
 * If the input is a JSON array, it processes each element.
 * If the input is a JSON object, it processes each value.
 * If the input is neither an array nor an object, returns `null`.
 *
 * Params:
 *   json = The input `Json` value to filter.
 *
 * Returns:
 *   An array of filtered `Json` objects, or `null` if the input is not an array or object.
 */
Json[] filterObjects(Json json) {
  if (json.isArray) {
    return filterObjects(json.toArray);
  }
  if (json.isObject) {
    return filterObjects(json.toMap);
  }
  return null;
}
/// 
unittest {
    // Test: filterObjects(Json) with array input containing objects and non-objects
    Json obj1 = ["foo": 1].toJson;
    Json obj2 = ["bar": 2].toJson;
    Json arr = [obj1, obj2, Json("str"), Json(42), Json(null)].toJson;

    auto result = filterObjects(arr);
    assert(result.length == 2, "Should return 2 objects from Json array");
    assert(result.canFind(obj1), "Should contain obj1");
    assert(result.canFind(obj2), "Should contain obj2");

    // Test: filterObjects(Json) with object input containing objects and non-objects
    Json[string] map;
    map["obj1"] = obj1;
    map["obj2"] = obj2;
    map["str"] = Json("str");
    map["num"] = Json(42);
    Json obj = map.toJson;

    auto resultObj = filterObjects(obj);
    assert(resultObj.length == 2, "Should return 2 objects from Json object");
    assert(resultObj.canFind(obj1), "Should contain obj1");
    assert(resultObj.canFind(obj2), "Should contain obj2");

    // Test: filterObjects(Json) with non-array/object input (string)
    Json str = Json("hello");
    auto resultStr = filterObjects(str);
    assert(resultStr is null || resultStr.length == 0, "Should return null or empty array for non-array/object Json");

    // Test: filterObjects(Json) with non-array/object input (number)
    Json num = Json(42);
    auto resultNum = filterObjects(num);
    assert(resultNum is null || resultNum.length == 0, "Should return null or empty array for non-array/object Json");

    // Test: filterObjects(Json) with null input
    Json nullVal = Json(null);
    auto resultNull = filterObjects(nullVal);
    assert(resultNull is null || resultNull.length == 0, "Should return null or empty array for null Json");
}

Json[] filterObjects(Json[] items) {
  return items.filter!(item => item.isObject).array;
}
///
unittest {
  // Test: filterObjects returns only objects from mixed Json array

  // Prepare test data
  Json obj1 = ["x": 1, "y": 2].toJson;
  Json obj2 = ["z": 3].toJson;
  Json arr = [1, 2, 3].toJson;
  Json str = Json("test");
  Json num = Json(123);
  Json nullVal = Json(null);

  Json[] items = [obj1, arr, str, obj2, num, nullVal];

  auto result = filterObjects(items);

  assert(result.length == 2, "Should return 2 objects");
  assert(result[0] == obj1, "First object should be obj1");
  assert(result[1] == obj2, "Second object should be obj2");

  // Test: filterObjects with no objects
  Json[] noObjects = [arr, str, num, nullVal];
  auto emptyResult = filterObjects(noObjects);
  assert(emptyResult.length == 0, "Should return empty array when no objects");

  // Test: filterObjects with all objects
  Json[] allObjects = [obj1, obj2];
  auto allResult = filterObjects(allObjects);
  assert(allResult.length == 2, "Should return all objects");
  assert(allResult[0] == obj1);
  assert(allResult[1] == obj2);
}
// #endregion filterObjects


// #region filterArrays
Json[] filterArrays(Json json) {
  if (json.isArray) {
    return filterArrays(json.toArray);
  }
  if (json.isObject) {
    return filterArrays(json.toMap);
  }
  return null;
}

Json[] filterObjects(Json[string] items) {
  return filterObjects(items.byValue.array);
}

Json[] filterArrays(Json[] items) {
  return items.filter!(item => item.isArray).array;
}
/// 
unittest {
  // Test: filterArrays returns only arrays from mixed Json array

  // Prepare test data
  Json obj1 = ["x": 1, "y": 2].toJson;
  Json obj2 = ["z": 3].toJson;
  Json arr1 = [1, 2, 3].toJson;
  Json arr2 = ["a", "b", "c"].toJson;
  Json str = Json("test");
  Json num = Json(123);
  Json nullVal = Json(null);

  Json[] items = [obj1, arr1, str, obj2, num, arr2, nullVal];

  auto result = filterArrays(items);

  assert(result.length == 2, "Should return 2 arrays");
  assert(result[0] == arr1, "First array should be arr1");
  assert(result[1] == arr2, "Second array should be arr2");

  // Test: filterArrays with no arrays
  Json[] noArrays = [obj1, obj2, str, num, nullVal];
  auto emptyResult = filterArrays(noArrays);
  assert(emptyResult.length == 0, "Should return empty array when no arrays");

  // Test: filterArrays with all arrays
  Json[] allArrays = [arr1, arr2];
  auto allResult = filterArrays(allArrays);
  assert(allResult.length == 2, "Should return all arrays");
  assert(allResult[0] == arr1);
  assert(allResult[1] == arr2);
}

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

/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.containers.maps.filter;

import uim.vibe;

mixin(Version!("test_uim_vibe"));
@safe:

// #region filterObjects
/**
 * Filters the values of a JSON string-keyed map and returns an array of JSON objects.
 *
 * Params:
 *   items = A map with string keys and JSON values to be filtered.
 *
 * Returns:
 *   An array of JSON objects resulting from the filtering operation.
 */
Json[] filterObjects(Json[string] items) {
  return uim.vibe.containers.arrays.filter.filterObjects(items.byValue.array);
}
/// 
unittest {
  // Test: filterObjects(Json[string]) returns only objects from a Json[string] map

  // Prepare test data
  Json object1 = ["a": 1].toJson;
  Json object2 = ["b": 2].toJson;
  Json arr = [1, 2].toJson;
  Json str = Json("hello");
  Json num = Json(42);
  Json nullVal = Json(null);

  Json[string] items;
  items["object1"] = object1;
  items["arr"] = arr;
  items["str"] = str;
  items["object2"] = object2;
  items["num"] = num;
  items["null"] = nullVal;

  auto result = filterObjects(items);

  assert(result.length == 2, "Should return 2 objects from Json[string]");
  assert(result.has(object1), "Should contain object1");
  assert(result.has(object2), "Should contain object2");

  // Test: filterObjects(Json[string]) with no objects
  Json[string] noObjects;
  noObjects["arr"] = arr;
  noObjects["str"] = str;
  noObjects["num"] = num;
  noObjects["null"] = nullVal;

  auto emptyResult = filterObjects(noObjects);
  assert(emptyResult.length == 0, "Should return empty array when no objects in Json[string]");

  // Test: filterObjects(Json[string]) with all objects
  Json[string] allObjects;
  allObjects["object1"] = object1;
  allObjects["object2"] = object2;

  auto allResult = filterObjects(allObjects);
  assert(allResult.length == 2, "Should return all objects from Json[string]");
  assert(allResult.has(object1));
  assert(allResult.has(object2));
}
// #endregion filterObjects

Json[] filterArrays(Json[string] items) {
  return uim.vibe.containers.arrays.filter.filterArrays(items.byValue.array);
}
/// 
unittest {
    // Prepare test data
    Json arr1 = [1, 2, 3].toJson;
    Json arr2 = ["x", "y"].toJson;
    Json obj = ["key": "value"].toJson;
    Json str = Json("test");
    Json num = Json(123);
    Json nullVal = Json(null);

    Json[string] items;
    items["arr1"] = arr1;
    items["arr2"] = arr2;
    items["obj"] = obj;
    items["str"] = str;
    items["num"] = num;
    items["null"] = nullVal;

    auto result = filterArrays(items);

    assert(result.length == 2, "Should return 2 arrays from Json[string]");
    assert(result.has(arr1), "Should contain arr1");
    assert(result.has(arr2), "Should contain arr2");

    // Test: filterArrays(Json[string]) with no arrays
    Json[string] noArrays;
    noArrays["obj"] = obj;
    noArrays["str"] = str;
    noArrays["num"] = num;
    noArrays["null"] = nullVal;

    auto emptyResult = filterArrays(noArrays);
    assert(emptyResult.length == 0, "Should return empty array when no arrays in Json[string]");

    // Test: filterArrays(Json[string]) with all arrays
    Json[string] allArrays;
    allArrays["arr1"] = arr1;
    allArrays["arr2"] = arr2;

    auto allResult = filterArrays(allArrays);
    assert(allResult.length == 2, "Should return all arrays from Json[string]");
    assert(allResult.has(arr1));
    assert(allResult.has(arr2));
}

Json[] filterValues(Json[string] items) {
  return uim.vibe.containers.arrays.filter.filterValues(items.byValue.array);
}
///
unittest {
    // Prepare test data
    Json obj1 = ["a": 1].toJson;
    Json arr1 = [1, 2].toJson;
    Json str1 = Json("hello");
    Json num1 = Json(42);
    Json nullVal = Json(null);

    Json[string] items;
    items["obj1"] = obj1;
    items["arr1"] = arr1;
    items["str1"] = str1;
    items["num1"] = num1;
    items["null"] = nullVal;

    auto result = filterValues(items);
    assert(result.length == 2, "Should return 2 values from Json[string]");
    assert(result.has(str1), "Should contain the string value");
    assert(result.has(num1), "Should contain the number value");
      

    // Test: filterValues(Json[string]) with empty map
    Json[string] emptyItems;
    auto emptyResult = filterValues(emptyItems);
    assert(emptyResult.length == 0, "Should return empty array when Json[string] is empty");

    // Test: filterValues(Json[string]) with one value
    Json[string] singleItem;
    singleItem["str"] = str1;
    auto singleResult = filterValues(singleItem);
    assert(singleResult.length == 1, "Should return one value");
    assert(singleResult[0] == str1, "Should contain the single value");
}


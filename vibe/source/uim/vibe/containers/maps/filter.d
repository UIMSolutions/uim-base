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
  return filterObjects(items.byValue.array);
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
  assert(result.canFind(object1), "Should contain object1");
  assert(result.canFind(object2), "Should contain object2");

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
  assert(allResult.canFind(object1));
  assert(allResult.canFind(object2));
}
// #endregion filterObjects

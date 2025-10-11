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
  Json obj1 = ["a": 1].toJson;
  Json obj2 = ["b": 2].toJson;
  Json arr = [1, 2].toJson;
  Json str = Json("hello");
  Json num = Json(42);
  Json nullVal = Json(null);

  Json[string] items;
  items["obj1"] = obj1;
  items["arr"] = arr;
  items["str"] = str;
  items["obj2"] = obj2;
  items["num"] = num;
  items["null"] = nullVal;

  auto result = filterObjects(items);

  assert(result.length == 2, "Should return 2 objects from Json[string]");
  assert(result.canFind(obj1), "Should contain obj1");
  assert(result.canFind(obj2), "Should contain obj2");

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
  allObjects["obj1"] = obj1;
  allObjects["obj2"] = obj2;

  auto allResult = filterObjects(allObjects);
  assert(allResult.length == 2, "Should return all objects from Json[string]");
  assert(allResult.canFind(obj1));
  assert(allResult.canFind(obj2));
}
// #endregion filterObjects

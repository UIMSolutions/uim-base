/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.algorithms.iterations.last;

import uim.vibe;

mixin(Version!("test_uim_vibe"));
@safe:

/** 
  * Returns the last element of a Json array or `null` if not an array.
  *
  * Params:
  *   json = The Json value to extract the last element from.
  *
  * Returns:
  *   The last element of the array if `json` is an array, otherwise `null`.
  */
Json last(Json json) pure nothrow {
  return json.isArray
    ? last(json.toArray) : Json(null);
}
/// 
unittest {
  // Test with a Json array
  Json arr = Json([Json(1), Json(2), Json(3)]);
  auto result = last(arr);
  assert(result == Json(3), "last should return the last element of the array");

  // Test with an empty Json array
  Json emptyArr = Json([]);
  auto emptyResult = last(emptyArr);
  assert(emptyResult == Json(null), "last should return Json(null) for empty array");

  // Test with a non-array Json value
  Json value = Json("test");
  auto valueResult = last(value);
  assert(valueResult == Json(null), "last should return Json(null) for non-array Json");
}

/** 
  * Returns an array containing the last 'numberOfValues' elements of the input array.
  *
  * Params:
  *   json = The Json array to extract elements from.
  *   numberOfValues = The number of elements to extract from the end of the array.
  *
  * Returns:
  *   An array containing the last 'numberOfValues' elements, a duplicate of the entire array if it has fewer than 'numberOfValues' elements, or null if the array is empty.
  */
Json[] lastMany(Json json, size_t numberOfValues) pure nothrow {
  return json.isArray
    ? lastMany(json.toArray, numberOfValues) : null;
}
///
unittest {
  // Test lastMany with a Json array and numberOfValues less than array length
  Json arr = Json([Json(1), Json(2), Json(3), Json(4)]);
  auto result = lastMany(arr, 2);
  assert(result.length == 2, "lastMany should return 2 elements");
  assert(result[0] == Json(3), "lastMany should return the correct elements");
  assert(result[1] == Json(4), "lastMany should return the correct elements");

  // Test lastMany with numberOfValues equal to array length
  auto resultAll = lastMany(arr, 4);
  assert(resultAll.length == 4, "lastMany should return all elements if numberOfValues equals array length");
  assert(resultAll == [Json(1), Json(2), Json(3), Json(4)], "lastMany should return all elements");

  // Test lastMany with numberOfValues greater than array length
  auto resultOver = lastMany(arr, 10);
  assert(resultOver.length == 4, "lastMany should not return more elements than exist in the array");
  assert(resultOver == [Json(1), Json(2), Json(3), Json(4)], "lastMany should return all elements");

  // Test lastMany with an empty Json array
  Json emptyArr = Json([]);
  auto emptyResult = lastMany(emptyArr, 3);
  assert(emptyResult.length == 0, "lastMany should return an empty array for empty Json array");

  // Test lastMany with a non-array Json value
  Json value = Json("test");
  auto valueResult = lastMany(value, 2);
  assert(valueResult is null, "lastMany should return null for non-array Json");
}

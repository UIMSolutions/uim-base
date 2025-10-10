/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.algorithms.iterations.first;

import uim.vibe;

mixin(Version!("test_uim_vibe"));
@safe:

// #region T first(Json json)
/**
  * Returns the first element of a Json array or `null` if not an array.
  *
  * Params:
  *   json = The Json value to extract the first element from.
  *
  * Returns:
  *   The first element of the array if `json` is an array, otherwise `null`.
  */
Json first(Json json) {
  return json.isArray
    ? first(json.toArray) : Json(null);
}
///
unittest {
  // Test: first(Json) with a non-array Json
  Json nonArray = Json(42);
  assert(first(nonArray) == Json(null), "Should return null for non-array Json");

  // Test: first(Json) with an empty array
  Json emptyArr = Json.emptyArray;
  assert(first(emptyArr) == Json(null), "Should return null for empty array");

  // Test: first(Json) with a single-element array
  Json singleArr = Json([Json("hello")]);
  assert(first(singleArr) == Json("hello"), "Should return the first element for single-element array");

  // Test: first(Json) with a multi-element array
  Json multiArr = Json([Json(1), Json(2), Json(3)]);
  assert(first(multiArr) == Json(1), "Should return the first element for multi-element array");

  // Test: first(Json) with a nested array
  Json nestedArr = Json([[Json("a"), Json("b")], [Json("c")]]);
  assert(first(nestedArr) == Json(["a", "b"]), "Should return the first nested array");
}
// #endregion T first(Json json)

// #region T first(T : Json)(T[] values)
/** 
  * Returns the first element of the array or `null` if the array is empty.
  *
  * Params:
  *   values = The array to get the first element from.
  *
  * Returns:
  *   The first element of the array or `null` if the array is empty.
  */
T first(T : Json)(T[] values) {
  return (values.length == 0)
    ? Json(null) : values[0];
}
///
unittest {
  // Test first(T)(T[] values) with non-empty Json array
  Json[] jsonArr = [Json(1), Json(2)];
  assert(jsonArr.first == Json(1));

  // Test first(T)(T[] values) with empty Json array
  Json[] emptyJsonArr;
  assert(emptyJsonArr.first == Json(null));
}
// #region T first(T : Json)(T[] values)

Json[] firstMany(Json json, size_t numberOfValues) {
  return json.isArray
    ? firstMany(json.toArray, numberOfValues) : null;
}

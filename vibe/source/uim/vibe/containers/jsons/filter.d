module uim.vibe.containers.jsons.filter;

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
  Json object1 = ["foo": 1].toJson;
  Json object2 = ["bar": 2].toJson;
  Json arr = [object1, object2, Json("str"), Json(42), Json(null)].toJson;

  auto result = filterObjects(arr);
  assert(result.length == 2, "Should return 2 objects from Json array");
  assert(result.has(object1), "Should contain object1");
  assert(result.has(object2), "Should contain object2");

  // Test: filterObjects(Json) with object input containing objects and non-objects
  Json[string] map;
  map["object1"] = object1;
  map["object2"] = object2;
  map["str"] = Json("str");
  map["num"] = Json(42);
  Json obj = map.toJson;

  auto resultObj = filterObjects(obj);
  assert(resultObj.length == 2, "Should return 2 objects from Json object");
  assert(resultObj.has(object1), "Should contain object1");
  assert(resultObj.has(object2), "Should contain object2");

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
/// 
unittest {
  // Test: filterArrays with array input containing arrays and non-arrays
  Json array1 = [1, 2, 3].toJson;
  Json array2 = ["a", "b"].toJson;
  Json arr = [array1, array2, Json("str"), Json(42), Json(null)].toJson;

  auto result = filterArrays(arr);
  assert(result is null || result.length == 0, "Should return null or empty array for array input");

  // Test: filterArrays with object input containing arrays and non-arrays
  Json[string] map;
  map["array1"] = array1;
  map["array2"] = array2;
  map["str"] = Json("str");
  map["num"] = Json(42);
  Json obj = map.toJson;

  auto resultObj = filterArrays(obj);
  assert(resultObj is null || resultObj.length == 0, "Should return null or empty array for object input");

  // Test: filterArrays with non-array/object input (string)
  Json str = Json("hello");
  auto resultStr = filterArrays(str);
  assert(resultStr is null || resultStr.length == 0, "Should return null or empty array for string input");

  // Test: filterArrays with non-array/object input (number)
  Json num = Json(42);
  auto resultNum = filterArrays(num);
  assert(resultNum is null || resultNum.length == 0, "Should return null or empty array for number input");

  // Test: filterArrays with null input
  Json nullVal = Json(null);
  auto resultNull = filterArrays(nullVal);
  assert(resultNull is null || resultNull.length == 0, "Should return null or empty array for null input");
}
// #endregion filterArrays

// #region filterValues
Json[] filterValues(Json json) {
  if (json.isArray) {
    return filterValues(json.toArray);
  }
  if (json.isObject) {
    return filterValues(json.toMap);
  }
  return null;
}
///
unittest {
  // Test: filterValues with array input containing mixed types
  Json arr = [Json("str"), Json(42), ["foo": 1].toJson, Json(null)].toJson;
  auto resultArr = filterValues(arr);
  assert(resultArr is null || resultArr.length == 0, "Should return null or empty array for array input");

  // Test: filterValues with object input containing mixed types
  Json[string] map;
  map["str"] = Json("str");
  map["num"] = Json(42);
  map["obj"] = ["foo": 1].toJson;
  Json obj = map.toJson;
  auto resultObj = filterValues(obj);
  assert(resultObj is null || resultObj.length == 0, "Should return null or empty array for object input");

  // Test: filterValues with non-array/object input (string)
  Json str = Json("hello");
  auto resultStr = filterValues(str);
  assert(resultStr is null || resultStr.length == 0, "Should return null or empty array for string input");

  // Test: filterValues with non-array/object input (number)
  Json num = Json(42);
  auto resultNum = filterValues(num);
  assert(resultNum is null || resultNum.length == 0, "Should return null or empty array for number input");

  // Test: filterValues with null input
  Json nullVal = Json(null);
  auto resultNull = filterValues(nullVal);
  assert(resultNull is null || resultNull.length == 0, "Should return null or empty array for null input");
}
// #endregion filterValues

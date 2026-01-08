/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.types.arrays.get;

import uim.root;

mixin(Version!("show_module"));

@safe:

// #region Json[]
// #region index
/**
  * Retrieves the array at the specified index from the Json array.
  *
  * Params:
  *  jsons = The array of Json objects to retrieve from.
  *  index = The index of the array to retrieve.
  *  defaultValue = The value to return if the index does not contain an array.
  *
  * Returns:
  *  The array at the specified index, or the default value if not found.
*/
Json getArray(Json[] jsons, size_t index, Json defaultValue = Json(null)) {
  return jsons.getValue(index).isArray() ? jsons[index] : defaultValue;
}
/// 
unittest {
  version (show_test)
    writeln("Testing getArray for Json[] with index");

  Json[] jsons = [[1, 2].toJson, ["a": 1].toJson, [3, 4].toJson];
  assert(jsons.getArray(0) == [1, 2].toJson, "Expected array at index 0");
  assert(jsons.getArray(1, Json("default")) == Json("default"), "Expected default value for non-array at index 1");
  assert(jsons.getArray(2) == [3, 4].toJson, "Expected array at index 2");
}
// #endregion index

// #region base
Json[] getArrays(Json[] jsons) {
  return jsons.filter!(json => json.isArray).array;
}
// #endregion base
// #endregion Json[]

// #region Json[string]
// #region path
/**
  * Retrieves the array at the specified path from the Json map.
  *
  * Params:
  *  map = The Json map to retrieve from.
  *  path = The path of the array to retrieve.
  *  defaultValue = The value to return if the path does not contain an array.
  *
  * Returns:
  *  The array at the specified path, or the default value if not found.
*/
Json getArray(Json[string] map, string[] path, Json defaultValue = Json(null)) {
  return map.getValue(path).isArray ? map.getValue(path) : defaultValue;
}
/// 
unittest {
  version (show_test)
    writeln("Testing getArray for Json[string] with path");

  Json[string] map = [
    "first": [1, 2].toJson, "second": ["a": 1].toJson, "third": [3, 4].toJson
  ];
  assert(map.getArray("first") == [1, 2].toJson, "Expected array at path 'first'");
  assert(map.getArray("second", Json("default")) == Json("default"), "Expected default value for non-array at path 'second'");
  assert(map.getArray("third") == [3, 4].toJson, "Expected array at path 'third'");
}
// #endregion path

// #region key
/**
  * Retrieves the array at the specified key from the Json map.
  *
  * Params:
  *  map = The Json map to retrieve from.
  *  key = The key of the array to retrieve.
  *  defaultValue = The value to return if the key does not contain an array.
  *
  * Returns:
  *  The array at the specified key, or the default value if not found.
*/
Json getArray(Json[string] map, string key, Json defaultValue = Json(null)) {
  return map.getValue(key).isArray ? map.getValue(key) : defaultValue;
}
/// 
unittest {
  version (show_test)
    writeln("Testing getArray for Json[string] with key");

  Json[string] map = [
    "first": [1, 2].toJson, "second": ["a": 1].toJson, "third": [3, 4].toJson
  ];
  assert(map.getArray("first") == [1, 2].toJson, "Expected array at key 'first'");
  assert(map.getArray("second", Json("default")) == Json("default"), "Expected default value for non-array at key 'second'");
  assert(map.getArray("third") == [3, 4].toJson, "Expected array at key 'third'");
}
// #endregion key

// #region base
Json[string] getArrays(Json[string] jsons) {
  Json[string] result;
  jsons.byKeyValue.filter!(kv => kv.value.isArray).each!(kv => result[kv.key] = kv.value);
  return result;
}
// #endregion Json[string]

// #region Json
// #region index
/**
  * Retrieves the array at the specified index from the Json object.
  *
  * Params:
  *  json = The Json object to retrieve from.
  *  index = The index of the array to retrieve.
  *  defaultValue = The value to return if the index does not contain an array.
  *
  * Returns:
  *  The array at the specified index, or the default value if not found.
*/
Json getArray(Json json, size_t index, Json defaultValue = Json(null)) {
  return json.isArray(index) ? json.getValue(index) : defaultValue;
}
/// 
unittest {
  version (show_test)
    writeln("Testing getArray with index");

  Json json = [[1, 2].toJson, ["a": 1].toJson, [3, 4].toJson].toJson;
  assert(json.getArray(0) == [1, 2].toJson, "Expected array at index 0");
  assert(json.getArray(1, Json("default")) == Json("default"), "Expected default value for non-array at index 1");
  assert(json.getArray(2) == [3, 4].toJson, "Expected array at index 2");
}
// #endregion index

// #region path
/**
  * Retrieves the array at the specified path from the Json object.
  *
  * Params:
  *  json = The Json object to retrieve from.
  *  path = The path of the array to retrieve.
  *  defaultValue = The value to return if the path does not contain an array.
  *
  * Returns:
  *  The array at the specified path, or the default value if not found.
*/
Json getArray(Json json, string[] path, Json defaultValue = Json(null)) {
  return json.isArray(path) ? json.getValue(path) : defaultValue;
}
/// 
unittest {
  version (show_test)
    writeln("Testing getArray with path");

  Json json = parseJsonString(`{"data": { "test": [ [1, 2], {"a": 1}, [3, 4] ]}}`);
  // assert(json.getArray(["data", "test"])[0] == [1, 2].toJson, "Expected array at path ['data', 'test'][0]");
  // assert(json.getArray(["data", "test"]).filterArrays()[0] == [1, 2].toJson, "Expected filtered array at path ['data', 'test'][0]");
}
// #endregion path

// #region key
/**
  * Retrieves the array at the specified key from the Json object.
  *
  * Params:
  *  json = The Json object to retrieve from.
  *  key = The key of the array to retrieve.
  *  defaultValue = The value to return if the key does not contain an array.
  *
  * Returns:
  *  The array at the specified key, or the default value if not found.
*/
Json getArray(Json json, string key, Json defaultValue = Json(null)) {
  return json.isArray(key) ? json.getValue(key) : defaultValue;
}
/// 
unittest {
  Json json = parseJsonString(`{"data": [ [1, 2], {"a": 1}, [3, 4] ]}`);
  assert(json.getArray("data") == [
      [1, 2].toJson, ["a": 1].toJson, [3, 4].toJson
    ].toJson);
  assert(json.getArray("nonexistent", Json("default")) == Json("default"), "Expected default value for non-array at key 'nonexistent'");
}
// #endregion key

Json getArrays(Json json) {
  if (json.isArray) {
    Json result = Json.emptyArray;
    json.byValue.filter!(value => value.isArray).each!(value => result ~= value);
    return result;     
  }
  if (json.isArray) {
    Json result = Json.emptyObject;
    json.byKeyValue.filter!(kv => kv.value.isArray).each!(kv => result[kv.key] = kv.value);
    return result;     
  }
  return Json(null);
}
// #endregion Json

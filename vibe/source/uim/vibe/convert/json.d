/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.convert.json;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region convert
T[] convert(T)(Json json, T delegate(string key, Json value) @safe func) {
  if (!json.isObject) {
    return null;
  }

  return json.byKeyValue.map!(kv => func(kv.key, kv.value)).array;
}

T[] convert(T)(Json json, T delegate(string key) @safe func) {
  if (!json.isObject) {
    return null;
  }

  return json.byKeyValue.map!(kv => func(kv.key)).array;
}

T[] convert(T)(Json json, T delegate(Json value) @safe func) {
  if (!json.isObject && !json.isArray) {
    return null;
  }

  return json.byValue.map!(value => func(value)).array;
}

unittest { // convert(Json, delegate(string, Json))
  // Prepare a Json object
  auto obj = Json.emptyObject;
  obj["a"] = 1;
  obj["b"] = 2;
  obj["c"] = 3;

  assert(obj.convert((string key, Json value) => key.length + value.get!int) == [
      4, 2, 3
    ]);
  assert(obj.convert((string key) => key.length) == [1, 1, 1]);
  assert(obj.convert((Json value) => value.get!int) == [3, 1, 2]);

  auto list = Json.emptyArray;
  list ~= 1;
  list ~= 2;
  list ~= 3;
  assert(list.convert((Json value) => value.get!int) == [1, 2, 3]);
}
// #endregion convert

/**
  * Converts a D associative array of strings to a Json object.
  *
  * Params:
  *   items = The associative array of strings to convert
  * Returns:
  *   A Json object representing the associative array
  */
Json toObject(Json[string] items) {
  if (items is null) {
    return Json(null);
  }

  Json result = Json.emptyObject;
  result = items.toJson;
  return result;
}
///
unittest {
  // Test toObject with null input
  Json[string] nullItems = null;
  auto result = toObject(nullItems);
  assert(result.type == Json.Type.null_);

// Test toObject with empty associative array
  Json[string] emptyItems;
  auto anotherResult = toObject(emptyItems);
  assert(anotherResult.type == Json.Type.object);
  assert(anotherResult.length == 0);

// Test toObject with single key-value pair
  Json[string] items1;
  items1["key1"] = Json("value1");
  auto result1 = toObject(items1);
  assert(result1.type == Json.Type.object);
  assert(result1["key1"] == "value1");

  // Test toObject with multiple key-value pairs
  Json[string] items2;
  items2["name"] = Json("John");
  items2["age"] = Json(30);
  items2["active"] = Json(true);

  auto result2 = toObject(items2);
  assert(result2.type == Json.Type.object);
  assert(result2["name"] == "John");
  assert(result2["age"] == 30);
  assert(result2["active"] == true);
  assert(result2.length == 3);

  // Test toObject with nested Json objects
  Json[string] items3;
  auto nested = Json.emptyObject;
  nested["inner"] = "value";
  items3["outer"] = nested;

  auto result3 = toObject(items3);
  assert(result3.type == Json.Type.object);
  assert(result3["outer"]["inner"] == "value");

  // Test toObject with Json arrays
  Json[string] items4;
  auto arr = Json.emptyArray;
  arr ~= 1;
  arr ~= 2;
  arr ~= 3;
  items4["numbers"] = arr;

  auto result4 = toObject(items4);
  assert(result4.type == Json.Type.object);
  assert(result4["numbers"][0] == 1);
  assert(result4["numbers"][1] == 2);
  assert(result4["numbers"][2] == 3);
}

/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.string_;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region getStringArray
string[] getStringArray(Json[string] map, string key, string[] defaultValue = null) {
  if (key !in map) return defaultValue;
  
  return map[key].getStringArray(defaultValue);
}

string[] getStringArray(Json json, string key, string[] defaultValue = null) {
  if (key !in json) return defaultValue;
  
  return json[key].getStringArray(defaultValue);
}

string[] getStringArray(Json json, string[] defaultValue = null) {
  if (!json.isArray) return defaultValue;
  
  return json.getArray
    .filter!(value => value.isString)
    .map!(value => value.get!string)
    .array;
}

string[] getStringArray(Json[] values) {
  return values
    .filter!(value => value.isString)
    .map!(value => value.get!string)
    .array;
}

string[] toStringArray(Json[] values) {
  return values.map!(value => value.to!string).array;
}
// #endregion getStringArray

// #region getStringMap
string[string] getStringMap(Json[string] map, string key, string[string] defaultValue = null) {
  return key in map
    ? map[key].getStringMap : defaultValue;
}

string[string] getStringMap(Json[] values, size_t index, string[string] defaultValue = null) {
  return values.length > index
    ? values[index].getStringMap : defaultValue;
}

string[string] getStringMap(Json value, string key, string[string] defaultValue = null) {
  return value.isObject && value.hasKey(key)
    ? value[key].getStringMap : defaultValue;
}

string[string] getStringMap(Json value, string[string] defaultValue = null) {
  if (!value.isObject) return defaultValue;

  return value.getMap.getStringMap;
}

string[string] getStringMap(Json[string] map, string[string] defaultValue = null) {
  string[string] results;
  map.byKeyValue.each!(kv => results[kv.key] = kv.value.getString);
  return results;
}

unittest {
    // getStringMap(Json[string] map, string key, string[string] defaultValue = null)
    Json[string] map;
    map["a"] = ["k1": "v1", "k2": "v2"].toJson;
    map["b"] = ["x": "y"].toJson;
    auto result = getStringMap(map, "a");
    assert(result.length == 2);
    assert(result["k1"] == "v1");
    assert(result["k2"] == "v2");

    // Key not present, should return defaultValue
    string[string] defValue = ["defValue": "val"];
    result = getStringMap(map, "c", defValue);
    assert(result.length == 1 && result["defValue"] == "val");
}

unittest {
    // getStringMap(Json[] values, size_t index, string[string] defaultValue = null)
    Json[] arr = [["a": "b"].toJson, ["c": "d"].toJson];
    auto result = getStringMap(arr, 0);
    assert(result.length == 1 && result["a"] == "b");

    result = getStringMap(arr, 1);
    assert(result.length == 1 && result["c"] == "d");

    // Out of bounds, should return defaultValue
    string[string] defValue = ["x": "y"];
    result = getStringMap(arr, 2, defValue);
    assert(result.length == 1 && result["x"] == "y");
}

unittest {
    // getStringMap(Json value, string key, string[string] defaultValue = null)
    Json obj = Json.emptyObject;
    obj["foo"] = ["bar": "baz"].toJson;
    auto result = getStringMap(obj, "foo");
    assert(result.length == 1 && result["bar"] == "baz");

    // Key not present, should return defaultValue
    string[string] defValue = ["notfound": "yes"];
    result = obj.getStringMap("missing", defValue);
    assert(result.length == 1 && result["notfound"] == "yes");

    // Not an object, should return defaultValue
    Json notObj = Json(42);
    result = getStringMap(notObj, "foo", defValue);
    assert(result.length == 1 && result["notfound"] == "yes");
}

unittest {
    // getStringMap(Json value, string[string] defaultValue = null)
    Json obj = ["a": "b", "c": "d"].toJson;
    auto result = getStringMap(obj);
    assert(result.length == 2 && result["a"] == "b" && result["c"] == "d");

    // Not an object, should return defaultValue
    Json notObj = Json(123);
    string[string] defValue = ["fallback": "ok"];
    result = getStringMap(notObj, defValue);
    assert(result.length == 1 && result["fallback"] == "ok");
}

unittest {
    // getStringMap(Json[string] map, string[string] defaultValue = null)
    Json[string] map;
    map["x"] = Json("y");
    map["z"] = Json("w");
    auto result = getStringMap(map);
    assert(result.length == 2);
    assert(result["x"] == "y");
    assert(result["z"] == "w");

    // Empty map
    Json[string] emptyMap;
    result = getStringMap(emptyMap);
    assert(result.length == 0);
}
// #endregion getStringMap

/* string[string] getStringMap(Json json, string[string] defaultValue = null) {
  if (!json.isObject) return defaultValue;

  string[string] results;
  json.byKeyValue.each!(kv => results[kv.key] = kv.value.getString);
  return results;
}
 */
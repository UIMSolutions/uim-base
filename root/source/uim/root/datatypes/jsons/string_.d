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

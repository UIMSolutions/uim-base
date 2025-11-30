/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.string_;

import uim.vibe;

mixin(Version!("test_uim_vibe"));
@safe:

// #region is
mixin(IsJsonFunctions!("String"));

// #region Json[string]
unittest {
  Json[string] map;
  map["a"] = Json("a");
  map["b"] = Json("b");

  assert(map.isAllString(["a", "b"]));
  assert(map.isAnyString(["a", "b"]));

  map["b"] = Json(8);
  assert(!map.isAllString(["a", "b"]));
  assert(map.isAnyString(["a", "b"]));

  map["a"] = Json(true);
  assert(!map.isAllString(["a", "b"]));
  assert(!map.isAnyString(["a", "b"]));
}
// #endregion Json[string]

// #region Json[]
unittest {
  auto values = [Json("a"), Json("b")];
  assert(values.isAnyString);
  assert(values.isAllString);

  values = [Json("a"), Json(3)];
  assert(values.isAnyString);
  assert(!values.isAllString);

  values = [Json(4), Json(5)];
  assert(!values.isAnyString);
  assert(!values.isAllString);

  assert(isAnyString([Json("a"), Json("b")]));
  assert(isAnyString([Json(7), Json("b")]));

  assert(!isAnyString([Json(7), Json(8)]));
  assert(isAllString([Json("a"), Json("b")]));

  assert(!isAllString([Json(7), Json("b")]));
  assert(!isAllString([Json(7), Json(8)]));
}
// #endregion Json[]

// #region Json
bool isString(Json json, bool strict = true) {
  if (strict) { // strict check for future use
    // TODO: Future use: check if json is a string or a number (int, float)
  }

  return (json.type == Json.Type.string);
}

unittest {
  auto json = parseJsonString(`{"a": "b", "c": {"d": 1}, "e": ["f", {"g": 1.1}], "i": {"j": "x"}}`);
  assert(json.isString("a"));
  assert(!json.isString("c"));
  assert(json.isString(["i", "j"])); // Check path i/j
  assert(!json.isString(["e", "g"])); // Check path e/g

  auto a = Json("a");
  assert(a.isString);
  assert(!a.isInteger);

  auto b = Json("b");
  auto c = Json(1);

  assert([a, b].isAnyString);
  assert([a, c].isAnyString);

  assert([a, b].isAllString);
  assert(![a, c].isAllString);

  auto map = ["A": a, "B": b, "C": c];
  assert(map.isAnyString(["A", "B"]));
  assert(map.isAnyString(["A", "C"]));

  assert(map.isAllString(["A", "B"]));
  assert(!map.isAllString(["A", "C"]));
}
// #endregion Json

unittest {
  assert(parseJsonString(`"a"`).isString);
  assert(!parseJsonString(`1.1`).isString);

  auto json = parseJsonString(`{"a": "b", "c": {"d": 1}, "e": ["f", {"g": 1.1}], "i": {"j": "x"}}`);
  assert(json.isString("a"));
  assert(!json.isString("c"));
  assert(json.isString(["i", "j"]));
  assert(!json.isString(["e", "g"]));
}

unittest {
  assert(!Json(true).isString);
  assert(!Json(10).isString);
  assert(!Json(1.1).isString);
  assert(Json("text").isString);

  Json map = Json.emptyObject;
  map["a"] = Json("a");
  map["b"] = Json("b");
  assert(map.isAllString(["a", "b"]));
  assert(map.isAnyString(["a", "b"]));

  map["b"] = Json(9);
  assert(!map.isAllString(["a", "b"]));
  assert(map.isAnyString(["a", "b"]));

  map["a"] = Json(true);
  assert(!map.isAllString(["a", "b"]));
  assert(!map.isAnyString(["a", "b"]));
}
// #endregion Json

unittest {
  assert(Json("text").isString);
  assert(!Json(10).isString);
  assert(!Json(1.1).isString);
  assert(!Json.emptyObject.isString);
  assert(!Json.emptyArray.isString);
  // assert(!Json.nullValue.isString);

  auto json = parseJsonString(`{"a": "b", "x": "y", "c": {"d": 1}, "e": ["f", {"g": "h"}]}`);
  assert(json.isString("a"));
  assert(!json.isString("c"));

  assert(json.isAllString(["a", "x"]));
  assert(!json.isAllString(["c", "d"]));

  assert(json.isAnyString(["c", "d", "x"]));
  assert(!json.isAnyString(["c", "d", "e"]));
  assert(json.isAnyString(["c", "d", "a"]));
}
// #endregion is

// #region get
mixin(GetJsonValue!("string", "String", "null"));

string getString(Json json) {
  // writeln("getString(Json json, string defaultValue = null): ", json.toString);

  return json.isString
    ? json.get!string : null;
}

unittest {
  Json json = Json("text");
  assert(json.getString == "text");

  json = Json.emptyArray;
  json ~= "a";
  json ~= "b";
  assert(json.getStringAt(0) == "a");
  assert(json.getStringAt(1) == "b");

  json = Json.emptyObject;
  json["a"] = "A";
  json["b"] = "B";
  // writeln(json.toString);
  // writeln(json["a"].toString, " - ", json["a"].length);
  // writeln(" --------------- ");
  // writeln(json["a"].getString, " - ", json.getString("a"), " - ", json.getString("a").length);

  assert(json.getString("a") == "A");
  assert(json.getString("b") == "B");

  auto list = [Json("a"), Json("b")];
  assert(list.getStringAt(0) == "a");
  assert(list.getStringAt(1) != "a");

  auto map = ["A": Json("a"), "B": Json("b")];
  assert(map.getString("A") == "a");
  assert(map.getString("B") != "a");
}
// #endregion get

// #region only
// #endregion only

// #region set  
// #endregion set

// #region remove
// #endregion remove

// #region clear
// #endregion clear

// #region to
// #endregion to

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
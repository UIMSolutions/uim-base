/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.data.json.base;

mixin(Version!("test_uim_vibe"));

import uim.vibe;
@safe:

// #region Null
V Null(V : Json)() {
  return Json(null);
}

unittest {
  assert(Null!Json == Json(null));
  assert(Null!Json.isNull);
}
// #endregion Null

// #region is
bool isMap(Json json) {
  return json.type == Json.Type.object;
}

// #region isArray

// #endregion isArray

// #endregion is

/// Check if jsonPath exists
bool hasPath(Json json, string path, string separator = "/") {
  if (!json.isObject) {
    return false;
  }

  auto pathItems = path.split(separator);
  return hasPath(json, pathItems);
}

bool hasPath(Json json, string[] path) {
  if (!json.isObject || path.length == 0) {
    return false;
  }

  if (!json.hasKey(path[0])) {
    return false;
  }

  return path.length == 1
    ? true : json[path[0]].hasPath(path[1 .. $]);
}

unittest {
  auto json = parseJsonString(`{"a": "b", "c": {"d": 1}, "e": ["f", {"g": "h"}]}`);
  assert(json.hasPath(["c", "d"]));
}

/* /// Check if jsonPath items exists
bool hasPath(Json json, string[] pathItems) {
  // In Check
  if (!json.isObject) {
    return false;
  }

  // Body
  auto j = json;
  foreach (pathItem; pathItems) {
    if (pathItem in j) {
      if (pathItems.length > 1) {
        return hasPath(j[pathItem], pathItems[1 .. $]);
      } else {
        return true;
      }
    } else {
      return false;
    }
  }
  return true;
} */
///
unittest {
  auto json = parseJsonString(`{"a": "b", "c": {"d": 1}, "e": ["f", {"g": "h"}]}`);
  assert(json.hasPath(["c", "d"]));
}

/// Reduce Json Object to keys (remove others)
Json reduceKeys(Json json, string[] keys) {
  if (json.isObject) {
    Json result = Json.emptyObject;
    keys
      .filter!(key => json.hasKey(key))
      .each!(key => result[key] = json[key]);

    return result;
  }
  return Json(null); // Not object or keys
}

unittest {
  writeln("test uim_core");
  // TODO 
}

/// Remove keys from Json Object
Json remove(Json json, string[] delKeys) {
  auto result = json;
  delKeys.each!(k => result.remove(k));
  return result;
}
///
unittest {
  auto json = parseJsonString(`{"a": "b", "c": {"d": 1}, "e": ["f", {"g": "h"}]}`);
  assert(json.hasValue(Json("b"), false));
  /* assert(json.hasValue(Json("h"), true)); */
}

/// Remove key from Json Object
Json remove(Json json, string aKey) {
  if (!json.isObject) {
    return json;
  }

  Json result = Json.emptyObject;
  json
    .byKeyValue
    .filter!(kv => kv.key != aKey)
    .each!(kv => result[kv.key] = kv.value);

  return result;
}

unittest {
  auto json = parseJsonString(`{"a": "b", "c": {"d": 1}, "e": ["f", {"g": "h"}]}`);
  assert(json.hasKey("a"));
  json.remove("a");
  assert(!json.hasKey("a"));

  json = parseJsonString(`{"a": "b", "c": {"d": 1}, "e": ["f", {"g": "h"}]}`);
  assert(!json.hasKey("x"));
  json.remove("x");
  assert(!json.hasKey("x"));
  json.remove("x");
  assert(json.hasKey("a"));
}

/// Load existing json files in directories
Json[] loadJsonsFromDirectories(string[] dirNames) {
  return dirNames
    .filter!(dir => dir.exists) // string[]
    .map!(dir => loadJsonsFromDirectory(dir)) // Json[][]
    .array // Json[][]
    .join;
}

unittest {
  /// TODO Add Tests
}

/// Load existing json file in directories
Json[] loadJsonsFromDirectory(string dirName) {
  // debug writeln("In loadJsonsFromDirectory("~dirName~")");
  // debug writeln("Found ", fileNames(dirName).length, " files");
  // TODO return loadJsons(fileNames(dirName, true));
  return null;
}

unittest {
  /// TODO Add Tests
}

Json[] loadJsons(string[] fileNames) {
  // debug writeln("Found ", fileNames.length, " names -> ", fileNames);
  return fileNames.map!(a => loadJson(a))
    .filter!(a => a != Json(null))
    .array;
}

unittest {
  /// TODO(John) Add Tests
}

Json loadJson(string name) {
  // debug writeln("In loadJson("~name~")");
  // debug writeln(name, " exists? ", name.exists);
  return name.exists ? parseJsonString(readText(name)) : Json(null);
}

unittest {
  /// TODO Add Tests
}

T minValue(T)(Json[] jsons, string key) {
  T result;
  foreach (j; jsons) { // find first value
    if (key !in j)
      continue;

    V value = j[key].get!T;
    result = value;
    break;
  } // found value

  jsons
    .filter!(json => key in json)
    .each!((json) {
      V value = json[key].get!T;
      if (value < result)
        result = value;
    });
  return result;
}

unittest {
  /*   assert(minValue!string(
      [
      ["a": "5"],
      ["a": "2"],
      ["a": "1"],
      ["a": "4"]
    ], "a") == "1"); */
}

T maxValue(T)(Json[] jsons, string key) {
  T result;
  foreach (json; jsons) { // find first value
    if (!json.hasKey(key)) {
      continue;
    }

    result = json[key].get!T;
    break;
  } // found value

  foreach (json; jsons) { // compare values
    if (!json.hasKey(key)) {
      continue;
    }

    V value = json[key].get!T;
    if (value > result)
      result = value;
  }
  return result;
}

unittest {
  /*     assert(maxValue!string(
        [
        ["a": "5"],
        ["a": "2"],
        ["a": "1"],
        ["a": "4"]
      ], "a") == "5");
 */
}

Json firstWithKey(Json[] jsons, string key) {
  Json[] results = jsons.filter!(json => json.hasKey(key)).array;
  return results.length > 0
    ? results[0] : Json(null);
}

unittest {
  /*   Json[] jsons;
  auto json = Json.emptyObject;
  jsons ~= json
    .set("a", 1)
    .set("b", 1);
  json = Json.emptyObject;
  jsons ~= json
    .set("a", 2)
    .set("b", 2);
  json = Json.emptyObject;
  jsons ~= json
    .set("a", 3)
    .set("b", 4);
  assert(jsons.firstWithKey("a").getLong("a") == 1);
  assert(jsons.firstWithKey("x") == Json(null)); */
}

Json mergeJsonObject(Json baseJson, Json mergeJson) {
  Json result;

  if (mergeJson.isEmpty || mergeJson.type != Json.Type.object) {
    return baseJson;
  }

  // TODO not finished
  return result;
}

Json jsonWithMinVersion(Json[] jsons) {
  if (jsons.length == 0) {
    return Json(null);
  }

  Json minJson = jsons[0];

  if (jsons.length > 1) {
    jsons[1 .. $]
      .filter!(json => json.isObject && "versionNumber" in json) // Object with versionNumber
      .each!(json => minJson = json["versionNumber"].get!size_t < minJson["versionNumber"].get!size_t
          ? json : minJson);
  }

  return minJson;
}
///
unittest {
  auto json1 = parseJsonString(`{"versionNumber": 1}`);
  auto json2 = parseJsonString(`{"versionNumber": 2}`);
  auto json3 = parseJsonString(`{"versionNumber": 3}`);

  assert(jsonWithMinVersion([json1, json2])["versionNumber"].get!size_t == 1);
  assert(jsonWithMinVersion([json1, json3, json2])["versionNumber"].get!size_t == 1);
  assert(jsonWithMinVersion([json3, json3, json2])["versionNumber"].get!size_t == 2);
}

Json jsonWithMaxVersion(Json[] jsons) {
  if (jsons.length == 0) {
    return Json(null);
  }

  auto result = jsons[0];

  if (jsons.length > 1) {
    jsons[1 .. $]
      .filter!(json => json.isObject && "versionNumber" in json)
      .each!(json => result = json["versionNumber"].get!size_t > result["versionNumber"].get!size_t ? json
          : result);
  }

  return result;
}
///
unittest {
  auto json1 = parseJsonString(`{"versionNumber": 1}`);
  auto json2 = parseJsonString(`{"versionNumber": 2}`);

  auto json3 = parseJsonString(`{"versionNumber": 3}`);

  assert(jsonWithMaxVersion([json1, json2])["versionNumber"].get!size_t == 2);
  assert(jsonWithMaxVersion([json1, json3, json2])["versionNumber"].get!size_t == 3);
  assert(jsonWithMaxVersion([json3, json3, json2])["versionNumber"].get!size_t == 3);
}

size_t maxVersionNumber(Json[] jsons) {
  if (jsons.length == 0) {
    return 0;
  }

  size_t result = 0;

  jsons
    .filter!(json => json.isObject && "versionNumber" in json)
    .each!(json => result = json["versionNumber"].get!size_t > result ? json["versionNumber"].get!size_t
        : result);

  return result;
}
///
unittest {
  auto json1 = parseJsonString(`{"versionNumber": 1}`);
  auto json2 = parseJsonString(`{"versionNumber": 2}`);
  auto json3 = parseJsonString(`{"versionNumber": 3}`);

  assert(maxVersionNumber([json1, json2]) == 2);
  assert(maxVersionNumber([json1, json3, json2]) == 3);
  assert(maxVersionNumber([json3, json3, json2]) == 3);
}

string[] toStringArray(Json value) {
  return value.isNull
    ? null
    : value.toArray.map!(json => json.to!string).array;
}

Json[] toArray(Json value) {
  if (value.isNull) {
    return null;
  }

  return value.isArray
    ? value.getArray
    : [value];
}

unittest {
  auto json1 = parseJsonString(`{"versionNumber": 1}`);
  // TODO create test
}

Json updateKey(Json origin, Json additional) {
  if (origin.type != additional.type) {
    return origin;
  } // no update

  if (!origin.isObject) {
    return additional;
  }

  Json updated = origin;
  additional.byKeyValue
    .each!(kv => updated[kv.key] = kv.value);

  return updated;
}

Json updateKey(Json origin, string[string] additional) {
  if (!origin.isObject) { // Overwrite if not object
    Json result = Json.emptyObject;
    additional.byKeyValue
      .each!(kv => result[kv.key] = Json(kv.value));

    return result;
  }

  // origin is Object
  Json updated = origin;
  additional.byKeyValue
    .each!(kv => updated[kv.key] = kv.value);

  return updated;
}

unittest {
  Json json = Json.emptyObject;
  json["a"] = "hallo";
  assert(json["a"].get!string == "hallo");
  json = json.set(["a": "world"]);
  assert(json["a"].get!string == "world");
}

Json toJsonObject(Json[string] items, string[] excludeKeys = null) {
  auto json = Json.emptyObject;
  items.byKeyValue
    .filter!(item => !excludeKeys.isAny!(key => key == item.key))
    .each!(item => json[item.key] = item.value);
  return json;
}

Json toJsonObject(string[string] map, string[] excludeKeys = null) {
  auto json = Json.emptyObject;
  map.byKeyValue
    .filter!(kv => !excludeKeys.isAny!(key => key == kv.key))
    .each!(kv => json[kv.key] = Json(kv.value));
  return json;
}

// #region get
// #region json
Json getJson(Json[string] map, string key, Json defaultValue = Json(null)) {
  return map.get(key, defaultValue);
}

Json getJson(Json[] values, size_t index, Json defaultValue = Json(null)) {
  return values.length > index
    ? values[index] : defaultValue;
}

Json getJson(Json value, string key, Json defaultValue = Json(null)) {
  return value.isObject && value.hasKey(key)
    ? value[key] : defaultValue;
}
// #endregion json

// #region map
Json[string] getMap(Json[string] map, string key, Json[string] defaultValue = null) {
  return key in map
    ? map[key].getMap : defaultValue;
}

Json[string] getMap(Json[] values, size_t index, Json[string] defaultValue = null) {
  return values.length > index
    ? values[index].getMap : defaultValue;
}

Json[string] getMap(Json value, string key, Json[string] defaultValue = null) {
  return value.isObject && value.hasKey(key)
    ? value[key].getMap : defaultValue;
}

Json[string] getMap(Json value, Json[string] defaultValue = null) {
  return value.isObject
    ? value.get!(Json[string]) : defaultValue;
}
// #endregion map

// #region set
Json set(Json json, Json map) {
  if (!json.isObject || !map.isObject) {
    return json;
  }

  map.byKeyValue.each!(kv => json.set(kv.key, kv.value));
  return json;
}

Json set(V)(Json json, V[string] values) {
  if (!json.isObject) {
    return json;
  }

  values.each!((key, value) => json.set(key, value));
  return json;
}

Json set(V)(Json json, string[] keys, V value) {
  if (!json.isObject) {
    return json;
  }

  keys.each!(key => json.set(key, value));
  return json;
}

// 
Json set(V)(Json json, string key, V value) {
  return json.isObject
    ? set(json, value.toJson) : json;
}

Json set(V : Json)(Json json, string key, V value) {
  if (!json.isObject) {
    return json;
  }

  json[key] = value;
  return json;
}

unittest {
  auto json = Json.emptyObject;
  json.set("a", "A");
  json.set("b", "B").set("c", "C");
  assert(json.hasAllKeys(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json = Json.emptyObject;
  json.set("a", Json("A"));
  json.set("b", Json("B")).set("c", Json("C"));
  assert(json.hasAllKeys(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json.set(["a", "b", "c"], "x");
  assert(json["a"] == Json("x") && json["b"] == Json("x") && json["c"] == Json("x"));

  json = Json.emptyObject;
  json.set(["a", "b", "c"], Json("x"));
  assert(json.hasAllKeys(["a", "b", "c"]));
  assert(json["a"] == Json("x") && json["b"] == Json("x") && json["c"] == Json("x"));

  json = Json.emptyObject;
  json.set(["a": "A", "b": "B", "c": "C"]);
  assert(json.hasAllKeys(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json = Json.emptyObject;
  json.set(["a": Json("A"), "b": Json("B"), "c": Json("C")]);
  assert(json.hasAllKeys(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  auto newJson = Json.emptyObject;
  newJson.set(json);
  assert(json.hasAllKeys(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));
}
// #endregion set

// #region merge
Json merge(Json json, Json map) {
  if (!json.isObject) {
    return json;
  }

  if (!map.isObject) {
    return json;
  }

  foreach (key, value; map.byKeyValue) {
    json = json.merge(key, value);
  }
  return json;
}

Json merge(V)(Json json, V[string] values) {
  if (!json.isObject) {
    return json;
  }

  values.each!((key, value) => json = json.merge(key, value));
  return json;
}

Json merge(V)(Json json, string[] keys, V value) {
  if (!json.isObject) {
    return json;
  }

  keys.each!(key => json = json.merge(key, value));
  return json;
}

Json merge(V)(Json json, string key, V value) {
  if (!json.isObject) {
    return json;
  }

  if (!json.hasKey(key))
    json[key] = value.toJson;

  return json;
}

Json merge(V : Json)(Json json, string key, V value) {
  if (!json.isObject) {
    return json;
  }

  if (!json.hasKey(key))
    json[key] = value;

  return json;
}

// TODO
/* unittest {
  auto json = Json.emptyObject;
  json.merge("a", "A");
  json.merge("b", "B").merge("c", "C");
  assert(json.hasAllKeys(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json = Json.emptyObject;
  json.merge("a", Json("A"));
  json.merge("b", Json("B")).merge("c", Json("C"));
  assert(json.hasAllKeys(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json.merge(["a", "b", "c"], "x");
  assert(json["a"] == Json("x") && json["b"] == Json("x") && json["c"] == Json("x"));

  json = Json.emptyObject;
  json.merge(["a", "b", "c"], Json("x"));
  assert(json.hasAllKeys(["a", "b", "c"]));
  assert(json["a"] == Json("x") && json["b"] == Json("x") && json["c"] == Json("x"));

  json = Json.emptyObject;
  json.merge(["a": "A", "b": "B", "c": "C"]);
  assert(json.hasAllKeys(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json = Json.emptyObject;
  json.merge(["a": Json("A"), "b": Json("B"), "c": Json("C")]);
  assert(json.hasAllKeys(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  auto newJson = Json.emptyObject;
  newJson.merge(json);
  assert(json.hasAllKeys(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));
}
 */ // #endregion merge

Json match(K)(Json[K] matchValues, K key, Json defaultValue = Json(null)) {
  return key in matchValues
    ? matchValues[key] : defaultValue;
}

// #region isSet
bool isSet(Json json, string key) {
  return json.isObject
    ? json.byKeyValue.isAny!(kv => kv.key == key) : false;
}
// #endregion isSet

// #region count
size_t count(Json value) {
  if (value.isNull) {
    return 0;
  }

  if (value.isObject) {
    return value.byKeyValue.array.length;
  }

  if (value.isArray) {
    return value.toArray.length;
  }

  return 1;
}

unittest {
  Json json = Json(null);
  assert(json.count == 0);

  json = Json("one");
  assert(json.count == 1);

  json = Json([Json("one"), Json("two")]);
  assert(json.count == 2);

  json = Json.emptyObject;
  json["one"] = 1;
  json["two"] = 2;
  json["three"] = 3;
  assert(json.count == 3);
}
// #endregion count

// #region remove
Json removeKeys(Json json, string[] keys) {
  keys.each!(key => json = json.removeKey(key));
  return json;
}

Json removeKey(Json json, string key) {
  json.remove(key);
  return json;
}
// #endregion remove

// #region filter
Json onlyKeys(Json json, string[] keys) {
  if (!json.isObject || keys.length == 0) {
    return Json(null);
  }

  auto result = Json.emptyObject;
  keys
    .filter!(key => json.hasKey(key))
    .each!(key => result[key] = json[key]);

  return result;
}

unittest {
  // TODO
}
// #endregion filter
// #region ifNull
Json ifNull(K : string, V:
  Json, T)(ref V[K] items, K key, T defaultValue) {
  return items.isNull(key) ? Json(defaultValue) : items[key];
}

Json ifNull(K : string, V:
  Json, T:
  Json)(ref V[K] items, K key, T defaultValue) {
  return items.isNull(key) ? defaultValue : items[key];
}

unittest {
  Json[string] map = ["a": Json("A"), "b": Json("B"), "c": Json("C")];
  assert(map.length == 3);

}
// #endregion ifNull

alias JMAP = Json[string];

// #region set
// Returns a new map with updated values for existing keys
ref set(K : string, V:
  Json, T:
  Json)(ref V[K] items, T[K] others, K[] keys = null) if (is(typeof(T) == Json)) {
  keys.length == 0
    ? others
    .each!((key, value) => items.set(key, value)) : keys
    .filter!(key => key in others)
    .each!(key => items.set(key, others[key]));

  return items;
}

/*   // Returns a new map with updated values for existing keys
  ref set(K : string, V:Json, T)(ref V[K] items, T[K] others, K[] keys = null) if (!is(typeof(T) == Json)) {
    keys.length == 0
      ? others
      .each!((key, value) => items.set(key, value)) : keys
      .filter!(key => key in others)
      .each!(key => items.set(key, others[key]));

    return items;
  }

  // returns a updated map with new values
  ref set(K : string, V:
    Json, T)(ref V[K] items, K[] keys, V value) {
    keys.each!(key => items.set(key, value));
    return items;
  } */

// returns a updated map with new values
// returns a updated map with new values

unittest {
  /*     Json[string] map1 = MapHelper.create!(string, Json)();
    map1.set("name", "Ozan");
    map1.set("classname", "UIManufaktur");
    writeln(map1);
    assert(map1.length == 2);

    Json[string] map = ["a": Json("A"), "b": Json("B"), "c": Json("C")];
    assert(map.length == 3);

    map.set("d", "x");
    assert(map.length == 4 && map.hasKey("d"));

    map.set("e", "x").set("f", "x");
    assert(map.length == 6 && map.hasAllKeys(["d", "e", "f"]));

    map = ["a": Json("A"), "b": Json("B"), "c": Json("C")]; // Reset map
    map.set(["d", "e", "f"], "x");
    assert(map.length == 6 && map.hasKey("d") && map["f"] == Json("x"));

    map = ["a": Json("A"), "b": Json("B"), "c": Json("C")]; // Reset map
    map.set("d", "x").set("e", "x").set("f", "x");
    assert(map.length == 6 && map.hasKey("d") && map["f"] == Json("x"));

    map = ["a": Json("A"), "b": Json("B"), "c": Json("C")]; // Reset map
    map.set(["d": "x", "e": "x", "f": "x"]);
    assert(map.length == 6 && map.hasKey("d") && map["f"] == Json("x"));

    map = ["a": Json(true), "b": Json(false), "c": Json(true)]; // Reset map
    assert(map.length == 3);

    map.set("d");
    assert(map.length == 4 && map.hasKey("d"));

    map = ["a": Json(true), "b": Json(false), "c": Json(true)]; // Reset map
    map.set(["d", "e", "f"], "x");
    assert(map.length == 6 && map.hasKey("d") && map["f"] == Json("x"));

    map = ["a": Json(true), "b": Json(false), "c": Json(true)]; // Reset map
    map.set("d", true).set("e", true).set("f", true);
    assert(map.length == 6 && map.hasKey("d") && map["f"] == Json(true));

    map = ["a": Json(true), "b": Json(false), "c": Json(true)]; // Reset map
    map.set(["d": true, "e": true, "f": true]);
    assert(map.length == 6 && map.hasKey("d") && map["f"] == Json(true));  
 */
}
// #endregion set

// #region update
/*   // Returns a updated map with updated of existing keys and new values
  // Returns a new map with updated values for existing keys
  ref update(K : string, V:
    Json, T)(ref V[K] items, T[K] merges, K[] keys = null) {
    keys.length == 0
      ? merges
      .each!((key, value) => items.update(key, value)) : keys
      .filter!(key => key in merges)
      .each!(key => items.update(key, merges[key]));

    return items;
  }

  // Returns a new map with updated values for existing keys
  ref update(K : string, V:
    Json, T)(ref V[K] items, K[] keys, V value) {
    keys
      .each!(key => items.update(key, value));
    return items;
  }
 */
// Returns a new map with updated values for existing keys
/*  ref update(K : string, V:
    Json, T)(ref V[K] items, K key, V value) if (!is(typeof(value) == Json)) {
    return items.update(key, Json(value));
  }

  // Returns a new map with updated values for existing keys
  ref update(K : string, V:
    Json, T)(ref V[K] items, K key, V value) if (!is(typeof(V) == typeof(T))) {
      return items.update(key, Json(value));
  }
 */
unittest {
  Json[string] map = ["a": Json("A"), "b": Json("B"), "c": Json("C")];
  assert(map.length == 3 && map.hasAllKeys(["a", "b", "c"]) && map["a"] == "A");

  /* map.update("a", "x").update("d", "x").update("e", "x").update("f", "x");
    assert(map.length == 3 && !map.hasAnyKeys(["d", "e", "f"]) && map["a"] == Json("x"));

    map = ["a": Json("A"), "b": Json("B"), "c": Json("C")]; // Reset map
    map.update(["c", "d", "e"], "x");
    assert(map.length == 3 && !map.hasAnyKeys(["d", "e", "f"]) && map["a"] != "x" && map["c"] == Json("x"));

    map = ["a": Json("A"), "b": Json("B"), "c": Json("C")]; // Reset map
    map.update(["a", "b", "c"], "x").update(["d", "e", "f"], "x");
    assert(map.length == 3 && !map.hasAnyKeys(["d", "e", "f"]) && map["a"] == Json("x") && map["c"] == Json(
        "x"));

    map = ["a": Json("A"), "b": Json("B"), "c": Json("C")]; // Reset map
    map.update(["c": "x", "d": "x", "e": "x"]);
    assert(map.length == 3 && !map.hasAnyKeys(["d", "e", "f"]) && map["a"] != "x" && map["c"] == Json(
        "x"));

    map = ["a": Json("A"), "b": Json("B"), "c": Json("C")]; // Reset map
    map.update(["c": "x", "d": "x", "e": "x"], "c", "e");
    assert(map.length == 3 && !map.hasAnyKeys(["d", "e", "f"]) && map["a"] != "x" && map["c"] == Json(
        "x")); */
}
// #endregion update

// #region merge
// Returns a updated map with updated of existing keys and new values
/* 

  // Returns a new map with updated values for existing keys
  ref merge(K : string, V:
    Json, T)(ref V[K] items, T[K] merges, K[] keys = null) if (!is(typeof(T) == Json)) {
    keys.length == 0
      ? merges
      .each!((key, value) => items.merge(key, value)) : keys
      .filter!(key => key in merges)
      .each!(key => items.merge(key, merges[key]));

    return items;
  }

  // Returns a new map with updated values for existing keys
  ref merge(K : string, V:
    Json, T)(ref V[K] items, K[] keys, V value) {
    keys
      .each!(key => items.merge(key, value));
    return items;
  }

  // Returns a new map with updated values for existing keys
  ref merge(K : string, V:
    Json, T)(ref V[K] items, K key, V value) if (!is(typeof(value) == Json)) {
    return items.merge(key, Json(value));
  }

  // Returns a new map with updated values for existing keys
  ref merge(K : string, V:
    Json, T)(ref V[K] items, K key, V value) if (!is(typeof(V) == typeof(T))) {
    return items.merge(key, Json(value));
  } */

unittest {
  Json[string] map = ["a": Json("A"), "b": Json("B"), "c": Json("C")];
  assert(map.length == 3 && map.hasAllKeys(["a", "b", "c"]) && map["a"] == "A");

  /* map.merge("a", "x").merge("d", "x").merge("e", "x").merge("f", "x");
    assert(map.length == 6 && map.hasAnyKeys(["d", "e", "f"]) && map["e"] == Json("x"));

    map = ["a": Json("A"), "b": Json("B"), "c": Json("C")]; // Reset map
    map.merge(["c", "d", "e"], "x");
    assert(map.length == 5 && map.hasAnyKeys(["d", "e", "f"]) && map["a"] != Json("x") && map["d"] == Json("x"));

    map = ["a": Json("A"), "b": Json("B"), "c": Json("C")]; // Reset map
    map.merge(["a", "b", "c"], "x").merge(["d", "e", "f"], "x");
    assert(map.length == 6 && map.hasAnyKeys(["d", "e", "f"]) && map["a"] != Json("x") && map["d"] == Json(
        "x"));

    map = ["a": Json("A"), "b": Json("B"), "c": Json("C")]; // Reset map
    map.merge(["c": "x", "d": "x", "e": "x"]);
    assert(map.length == 5 && map.hasAnyKeys(["d", "e", "f"]) && map["a"] != "x" && map["d"] == Json(
        "x"));

    map = ["a": Json("A"), "b": Json("B"), "c": Json("C")]; // Reset map
    map.merge(["c": "x", "d": "x", "e": "x"], "c", "e");
    assert(map.length == 4 && map.hasAnyKeys(["d", "e", "f"]) && map["a"] != "x" && map["e"] == Json(
        "x")); */
}
// #endregion merge

// #region getStringArray
string[] getStringArray(Json[string] map, string[] keys) {
  return keys
    .filter!(key => map.hasKey(key))
    .map!(key => map.getString(key))
    .array;
}

unittest {
  Json[string] values;

  Json testArray = Json.emptyArray;
  testArray ~= "A";
  testArray ~= "B";

  values["a"] = Json("A");
  values["b"] = "B".toJson;
  // assert(values.getStringArray(["a"]) == ["a": "A"]);
}
// #endregion getStringArray

// #region getStringMap
string[string] getStringMap(Json[string] items, string[] keys) {
  string[string] results;
  keys.each!(key => results[key] = items.getString(key));
  return results;
}

unittest {
  Json[string] values;

  Json testArray = Json.emptyArray;
  testArray ~= "A";
  testArray ~= "B";

  values["a"] = Json("A");
  values["b"] = "B".toJson;
  // assert(values.getStringMap(["a"]) == ["a": "A"]);
}
// #endregion getStringMap
// #endregion Getter

Json[string] copy(Json[string] values, string[] keys = null) {
  if (keys.length == 0) {
    return values.dup;
  }

  Json[string] results;
  keys
    .filter!(key => values.hasKey(key))
    .each!(key => results[key] = values[key]);

  return results;
}

Json[string] onlyKeys(Json[string] values, string[] keys) {
  if (keys.length == 0) {
    return values.dup;
  }

  Json[string] filteredData;
  keys
    .filter!(key => key in values)
    .each!(key => filteredData[key] = values[key]);

  return filteredData;
}

/* Json[string] onlyKeys(Json[string] values, string[] keys, string[] excludeKeys) {
  if (keys.length == 0) {
    return values.dup;
  }

  Json[string] filteredData;
  keys
    .filter!(key => key in values && !excludeKeys.has(key))
    .each!(key => filteredData[key] = values[key]);

  return filteredData;
}

Json[string] onlyKeys(Json[string] values, string[] keys, string excludeKey) {
  if (keys.length == 0) {
    return values.dup;
  }

  Json[string] filteredData;
  keys
    .filter!(key => key in values && key != excludeKey)
    .each!(key => filteredData[key] = values[key]);

  return filteredData;
}
 */

// #region set
// #region Json[string]
Json[string] setValues(V)(Json[string] items, V[string] values) {
  auto results = items.dup;
  values.each!((key, value) => results = results.setValue(key, value));
  return results;
}

Json[string] setValues(V)(Json[string] items, string[] keys, V value) {
  auto results = items.dup;
  keys.each!(key => results = results.setValue(key, value));
  return results;
}

Json[string] setValue(V)(Json[string] items, string[] path, V value) {
  Json[string] result = items.dup;
  if (path.length == 0) {
    return result;
  }

  if (path.length == 1) {
    return setValue(result, path[0], value);
  }

  if (!result.hasKey(path[0])) {
    results[path[0]] = Json.emptyObject;
  }

  result[path[0]] = setValue(result[path[0]], path[1 .. $], value);

  return result;
}

Json[string] setValue(V)(Json[string] items, string key, V value) {
  return setValue(items, key, value.toJson);
}

Json[string] setValue(V : Json)(Json[string] items, string key, V value) {
  auto results = items.dup;
  if (key !in results) {
    items[key] = value;
  }
  return results;
}

unittest {
  Json[string] items = null;
  items = items.setValue("a", Json("A"));
  assert(items["a"] == Json("A"));
  items = items.setValue("b", Json("B")).setValue("c", Json("C"));
  assert(items.hasAllKeys(["a", "b", "c"]));
  assert(items["a"] == Json("A") && items["b"] == Json("B") && items["c"] == Json("C"));

  items = null;
  items = items.setValue("a", "A");
  assert(items["a"] == Json("A"));
  items = items.setValue("b", "B").setValue("c", "C");
  assert(items.hasAllKeys(["a", "b", "c"]));
  assert(items["a"] == Json("A") && items["b"] == Json("B") && items["c"] == Json("C"));

  items = null;
  items = items.setValue("a", "A");
  assert(items["a"] == Json("A"));
  items = items.setValues(["b", "c"], "X");
  assert(items.hasAllKeys(["a", "b", "c"]));
  assert(items["a"] == Json("A") && items["b"] == Json("X") && items["c"] == Json("X"));

  items = null;
  items = items.setValue("a", "A");
  assert(items["a"] == Json("A"));
  items = items.setValues(["b": "B", "c": "C"]);
  assert(items.hasAllKeys(["a", "b", "c"]));
  assert(items["a"] == Json("A") && items["b"] == Json("B") && items["c"] == Json("C"));
}
// #endregion Json[string]

// #region Json
Json setValues(V)(Json json, V[string] values) {
  values.each!((key, value) => json = json.setValue(key, value));
  return json;
}

Json setValues(V)(Json json, string[] keys, V value) {
  keys.each!(key => json = json.setValue(key, value));
  return json;
}

Json setValue(V)(Json json, string[] path, V value) {
  Json result = json;
  if (path.length == 0) {
    return result;
  }

  if (path.length == 1) {
    return setValue(result, path[0], value);
  }

  if (path[0] !in result) {
    result[path[0]] = Json.emptyObject;
  }

  result[path[0]] = setValue(result[path[0]], path[1 .. $], value);
  return result;
}

Json setValue(V)(Json json, string key, V value) {
  return setValue(json, key, value.toJson);
}

Json setValue(V : Json)(Json json, string key, V value) {
  auto result = json;

  if (result.isNull) {
    result = Json.emptyObject;
  }

  if (result.isObject) {
    result[key] = value;
  }

  return result;
}

unittest {
  auto json = Json.emptyObject;
  json = json.setValue("a", Json("A"));
  assert(json["a"] == Json("A"));
  json = json.setValue("b", Json("B")).setValue("c", Json("C"));
  assert(json.hasAllKeys(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json = Json.emptyObject;
  json = json.setValue("a", "A");
  assert(json["a"] == Json("A"));
  json = json.setValue("b", "B").setValue("c", "C");
  assert(json.hasAllKeys(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json = Json.emptyObject;
  json["a"] = Json.emptyObject;
  json["a"]["aa"] = "xx";
  json = json.setValue(["a", "aa"], "A");
  assert(json["a"]["aa"] == Json("A"));

  json = Json.emptyObject;
  json = json.setValue("a", "A");
  assert(json["a"] == Json("A"));
  json = json.setValues(["b", "c"], "X");
  assert(json.hasAllKeys(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("X") && json["c"] == Json("X"));

  json = Json.emptyObject;
  json = json.setValue("a", "A");
  assert(json["a"] == Json("A"));
  json = json.setValues(["b": "B", "c": "C"]);
  assert(json.hasAllKeys(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));
}
// #region Json
// #endregion set

// #region update
// #endregion Json[string]
Json[string] updateValues(T)(Json[string] items, T[string] values) {
  auto results = items.dup;
  values.byKeyValue.each!(kv => results = results.updateValue(kv.key, kv.value));
  return results;
}

Json[string] updateValues(V)(Json[string] items, string[] keys, V value) {
  auto results = items.dup;
  keys.each!(key => results = results.updateValue(key, value));
  return results;
}

Json updateValue(V)(Json[string] items, string[] path, V value) {
  if (path.length == 0) {
    return items;
  }
  return path.length == 1
    ? updateValue(items, path[0], value) : updateValue(items, path[0], json[items[0]].updateValue(path[1 .. $], value));
}

Json[string] updateValue(V)(Json[string] items, string key, V value) {
  return updateValue(items, key, value.toJson);
}

Json[string] updateValue(V : Json)(Json[string] items, string key, V value) {
  auto results = items.dup;
  if (key in results) {
    items[key] = value;
  }
  return results;
}

Json[string] updateValue(V)(Json json, string key, V value) {
  return updateValue(items, key, value.toJson);
}

Json[string] updateValue(V : Json)(Json json, string key, V value) {
  if (key in json) {
    json[key] = value;
  }
  return json;
}

unittest {
  Json[string] items = null;
  items = items.setValue("a", Json("A"));
  assert(items["a"] == Json("A"));
  items = items.updateValue("a", Json("B")).updateValue("a", Json("C"));
  assert(items["a"] == Json("C"));

  items = null;
  items = items.setValue("a", Json("A"));
  assert(items["a"] == "A");
  items = items.updateValue("a", "B").updateValue("a", "C");
  assert(items["a"] == "C");

  auto json = Json.emptyObject;
  json["a"] = Json.emptyObject;
  json["a"]["aa"] = "xx";
 /*  json = json.updateValue(["a", "aa"], "A");
  assert(json["a"]["aa"] == Json("A")); */

  items = ["a": Json("A"), "b": Json("B"), "c": Json("C")];
  items = items.updateValue("a", "X");
  items = items.updateValues(["b", "c"], "X");
  assert(items["a"] == Json("X") && items["b"] == Json("X") && items["c"] == Json("X"));

  items = ["a": Json("A"), "b": Json("B"), "c": Json("C")];
  items = items.updateValues(["a": "X", "b": "X", "c": "X"]);
  assert(items["a"] == Json("X") && items["b"] == Json("X") && items["c"] == Json("X"));
}
// #endregion Json[string]

// #region Json
Json updateValues(V)(Json items, V[string] values) {
  auto results = items.dup;
  values.each!((key, value) => results = results.updateValue(key, value));
  return results;
}

Json updateValues(V)(Json items, string[] keys, V value) {
  auto results = items.dup;
  keys.each!(key => results = results.updateValue(key, value));
  return results;
}

Json updateValue(V)(Json json, string key, V value) {
  return updateValue(json, key, value.toJson);
}

Json updateValue(V : Json)(Json json, string key, V value) {
  auto results = json.dup;
  if (results.isObject && key in results) {
    items[key] = value;
  }
  return results;
}

unittest {
  Json[string] items = null;
  items = items.setValue("a", Json("A"));
  assert(items["a"] == Json("A"));
  items = items.updateValue("a", Json("B")).updateValue("a", Json("C"));
  assert(items["a"] == Json("C"));

  items = null;
  items = items.setValue("a", Json("A"));
  assert(items["a"] == "A");
  items = items.updateValue("a", "B").updateValue("a", "C");
  assert(items["a"] == "C");

  items = ["a": Json("A"), "b": Json("B"), "c": Json("C")];
  items = items.updateValue("a", "X");
  items = items.updateValues(["b", "c"], "X");
  assert(items["a"] == Json("X") && items["b"] == Json("X") && items["c"] == Json("X"));

  items = ["a": Json("A"), "b": Json("B"), "c": Json("C")];
  items = items.updateValues(["a": "X", "b": "X", "c": "X"]);
  assert(items["a"] == Json("X") && items["b"] == Json("X") && items["c"] == Json("X"));
}
// #region Json
// #endregion update

// #region merge
// #region Json[string]
Json[string] mergeValues(V)(Json[string] items, Json map) {
  auto results = items.dup;
  
  if (!map.isObject) {
    return results;
  }

  values.each!((key, value) => results = results.mergeValue(key, value));
  return results;
}

Json[string] mergeValues(V)(Json[string] items, V[string] values) {
  auto results = items.dup;
  values.each!((key, value) => results = results.mergeValue(key, value));
  return results;
}

Json[string] mergeValues(V)(Json[string] items, string[] keys, V value) {
  auto results = items.dup;
  keys.each!(key => results = results.mergeValue(key, value));
  return results;
}

Json mergeValue(V)(Json[string] items, string[] path, V value) {
  if (path.length == 0) {
    return items;
  }
  return path.length == 1
    ? mergeValue(items, path[0], value) : mergeValue(items, path[0], json[items[0]].mergeValue(path[1 .. $], value));
}

Json[string] mergeValue(V)(Json[string] items, string key, V value) {
  return mergeValue(items, key, value.toJson);
}

Json[string] mergeValue(V : Json)(Json[string] items, string key, V value) {
  auto results = items.dup;
  if (key !in results) {
    items[key] = value;
  }
  return results;
}

unittest {
  Json json = Json.emptyObject;
  json = json.mergeValue("a", Json("A"));
  assert(json["a"] == Json("A"));
  json = json.mergeValue("b", Json("B")).mergeValue("c", Json("C"));
  assert(json.hasAllKeys(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));
  json = json.mergeValue("a", Json("X"));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json = Json.emptyObject;
  json = json.mergeValue("a", "A");
  assert(json["a"] == Json("A"));
  json = json.mergeValue("b", "B").mergeValue("c", "C");
  assert(json.hasAllKeys(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));
  json = json.mergeValue("a", "X");
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json = Json.emptyObject;
  json["a"] = Json.emptyObject;
  json["a"]["aa"] = "X";
  json = json.mergeValue(["a", "aa"], "A");
  assert(json["a"]["aa"] == Json("X"));
  json = json.mergeValue(["a", "bb"], "B");
  assert(json["a"]["bb"] == Json("B"));

  json = Json.emptyObject;
  json = json.mergeValue("a", "A");
  assert(json["a"] == Json("A"));
  json = json.mergeValues(["b", "c"], "X");
  assert(json.hasAllKeys(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("X") && json["c"] == Json("X"));
  json = json.mergeValue("a", "X");
  assert(json["a"] == Json("A") && json["b"] == Json("X") && json["c"] == Json("X"));
  json = json.mergeValues(["b", "c"], "-");
  assert(json["a"] == Json("A") && json["b"] == Json("X") && json["c"] == Json("X"));

  json = Json.emptyObject;
  json = json.mergeValue("a", "A");
  assert(json["a"] == Json("A"));
  json = json.mergeValues(["b": "B", "c": "C"]);
  assert(json.hasAllKeys(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));
  json = json.mergeValue("a", "X");
  assert(json["a"] == Json("A") && json["b"] == Json("X") && json["c"] == Json("X"));
  json = json.mergeValues(["b": "X", "c": "X"]);
  assert(json["a"] == Json("A") && json["b"] == Json("X") && json["c"] == Json("X"));
}
// #endregion Json[string]

// #region Json
Json mergeValues(V)(Json items, V[string] values) {
  auto results = items.dup;
  values.each!((key, value) => results = results.mergeValue(key, value));
  return results;
}

Json mergeValues(V)(Json json, string[] keys, V value) {
  if (keys.length == 0) {
    return json;
  }
  keys.each!(key => json = json.mergeValue(key, value));
  return json;
}

Json mergeValue(V)(Json json, string[] path, V value) {
  if (path.length == 0) {
    return json;
  }
  return path.length == 1
    ? mergeValue(json, path[0], value) 
    : mergeValue(json, path[0], json[path[0]].mergeValue(path[1 .. $], value));
}

Json mergeValue(V)(Json json, string key, V value) {
  return mergeValue(json, key, value.toJson);
}

Json mergeValue(V : Json)(Json json, string key, V value) {
  auto result = json;
  if (result.isObject && key !in result) {
    json[key] = value;
  }
  return result;
}
// #region Json
unittest {
  Json json = Json.emptyObject;
  json = json.mergeValue("a", Json("A"));
  assert(json["a"] == Json("A"));
  json = json.mergeValue("b", Json("B")).mergeValue("c", Json("C"));
  assert(json.hasAllKeys(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));
  json = json.mergeValue("a", Json("X"));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json = Json.emptyObject;
  json = json.mergeValue("a", "A");
  assert(json["a"] == Json("A"));
  json = json.mergeValue("b", "B").mergeValue("c", "C");
  assert(json.hasAllKeys(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));
  json = json.mergeValue("a", "X");
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json = Json.emptyObject;
  json = json.mergeValue("a", "A");
  assert(json["a"] == Json("A"));
  json = json.mergeValues(["b", "c"], "X");
  assert(json.hasAllKeys(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("X") && json["c"] == Json("X"));
  json = json.mergeValue("a", "X");
  assert(json["a"] == Json("A") && json["b"] == Json("X") && json["c"] == Json("X"));
  json = json.mergeValues(["b", "c"], "-");
  assert(json["a"] == Json("A") && json["b"] == Json("X") && json["c"] == Json("X"));

  json = Json.emptyObject;
  json = json.mergeValue("a", "A");
  assert(json["a"] == Json("A"));
  json = json.mergeValues(["b": "B", "c": "C"]);
  assert(json.hasAllKeys(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));
  json = json.mergeValue("a", "X");
  assert(json["a"] == Json("A") && json["b"] == Json("X") && json["c"] == Json("X"));
  json = json.mergeValues(["b": "X", "c": "X"]);
  assert(json["a"] == Json("A") && json["b"] == Json("X") && json["c"] == Json("X"));
}
// #endregion merge

/* Json[string] setNull(Json[string] items, string[] path) {
  return set(items, path, Json(null));
}

Json[string] setNull(Json[string] items, string key) {
  return set(items, key, Json(null));
}

Json[string] setPath(T)(Json[string] items, string[] path, V value) {
  set(items, path, Json(value));
  return items;
}

Json[string] setPath(Json[string] items, string[] path, Json value) {
  if (path.length == 0) {
    return items;
  }

  if (path.length == 1) {
    return set(items, path[0], value);
  } */

/*   Json json = Json.emptyObject;
  return set(items, path[0], json.set(path[1..$], value));                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           ;
 */
/*   return null;
} */

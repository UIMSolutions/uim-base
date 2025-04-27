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
  assert(json.hasValue(Json("b")));
  assert(json.hasValue(Json("h"), true));
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

Json readJson(Json target, Json source, bool shouldOverwrite = true) {
  if (!target.isObject || !source.isObject) {
    return target;
  }

  auto result = target;
  source.byKeyValue.each!((kv) {
    if (shouldOverwrite) {
      result[kv.key] = kv.value;
    } else {
      if (!result.hasKey(kv.key)) {
        result[kv.key] = kv.value;
      }
    }
  });

  return result;
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

    T value = j[key].get!T;
    result = value;
    break;
  } // found value

  jsons
    .filter!(json => key in json)
    .each!((json) {
      T value = json[key].get!T;
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

    T value = json[key].get!T;
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

// #region merge
/// Merge jsons objects to one
/// Merge jsons objects in array to one
Json mergeJsons(Json[] jsons, bool shouldOverwrite = true) {
  Json result = Json.emptyObject;

  jsons
    .filter!(json => json.isObject)
    .each!(json => result = result.mergeJsonObjects(json, shouldOverwrite));

  return result;
}
///
/* unittest {
  auto json0 = parseJsonString(`{"a": "b", "c": {"d": 1}}`);
  auto json1 = parseJsonString(`{"e": ["f", {"g": "h"}]}`);
  auto mergeJson = mergeJsons(json0, json1);
  assert(mergeJson.hasKey("a") && mergeJson.hasKey("e"), mergeJson.toString);
} */

Json mergeJsonObjects(Json baseJson, Json mergeJson, bool shouldOverwrite = true) {
  Json result = Json.emptyObject;
  if (baseJson.isNull && !baseJson.isObject) {
    return result;
  }
  result = result.readJson(baseJson, shouldOverwrite);

  if (mergeJson.isNull && !mergeJson.isObject) {
    return result;
  }
  result = result.readJson(mergeJson, shouldOverwrite);

  // Out
  return result;
}

///
unittest {
  auto json0 = parseJsonString(`{"a": "b", "c": {"d": 1}}`);
  auto json1 = parseJsonString(`{"e": ["f", {"g": "h"}]}`);
  auto mergeJson = mergeJsonObjects(json0, json1);
  assert(mergeJson.hasKey("a") && mergeJson.hasKey("e"), mergeJson.toString);
}
// #endregion merge

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

  assert(jsonWithMinVersion(json1, json2)["versionNumber"].get!size_t == 1);
  assert(jsonWithMinVersion([json1, json2])["versionNumber"].get!size_t == 1);

  assert(jsonWithMinVersion(json1, json3, json2)["versionNumber"].get!size_t == 1);
  assert(jsonWithMinVersion([json1, json3, json2])["versionNumber"].get!size_t == 1);

  assert(jsonWithMinVersion(json3, json3, json2)["versionNumber"].get!size_t == 2);
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

  assert(jsonWithMaxVersion(json1, json2)["versionNumber"].get!size_t == 2);
  assert(jsonWithMaxVersion([json1, json2])["versionNumber"].get!size_t == 2);

  assert(jsonWithMaxVersion(json1, json3, json2)["versionNumber"].get!size_t == 3);
  assert(jsonWithMaxVersion([json1, json3, json2])["versionNumber"].get!size_t == 3);

  assert(jsonWithMaxVersion(json3, json3, json2)["versionNumber"].get!size_t == 3);
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

  assert(maxVersionNumber(json1, json2) == 2);
  assert(maxVersionNumber([json1, json2]) == 2);

  assert(maxVersionNumber(json1, json3, json2) == 3);
  assert(maxVersionNumber([json1, json3, json2]) == 3);

  assert(maxVersionNumber(json3, json3, json2) == 3);
  assert(maxVersionNumber([json3, json3, json2]) == 3);
}

string[] toStringArray(Json value) {
  if (value.isNull) {
    return null;
  }

  return value.toArray.map!(json => json.to!string).array;
}

Json[] toArray(Json value) {
  if (value.isNull) {
    return null;
  }

  if (value.isArray) {
    return value.getArray;
  }

  writeln("return [value]");
  return [value];
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
    .filter!(item => !excludeKeys.any!(key => key == item.key))
    .each!(item => json[item.key] = item.value);
  return json;
}

Json toJsonObject(string[string] map, string[] excludeKeys = null) {
  auto json = Json.emptyObject;
  map.byKeyValue
    .filter!(kv => !excludeKeys.any!(key => key == kv.key))
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
ref set(ref Json json, Json map) {
  if (!json.isObject) {
    return json;
  }

  if (!map.isObject) {
    return json;
  }

  map.byKeyValue.each!(kv => json.set(kv.key, kv.value));
  return json;
}

ref set(T)(ref Json json, T[string] values) {
  if (!json.isObject) {
    return json;
  }

  values.each!((key, value) => json.set(key, value));
  return json;
}

ref set(T)(ref Json json, string[] keys, T value) {
  if (!json.isObject) {
    return json;
  }

  keys.each!(key => json.set(key, value));
  return json;
}

// 
ref set(T)(ref Json json, string key, T value) {
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
  assert(json.hasAllKeys("a", "b", "c"));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json = Json.emptyObject;
  json.set("a", Json("A"));
  json.set("b", Json("B")).set("c", Json("C"));
  assert(json.hasAllKeys("a", "b", "c"));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json.set(["a", "b", "c"], "x");
  assert(json["a"] == Json("x") && json["b"] == Json("x") && json["c"] == Json("x"));

  json = Json.emptyObject;
  json.set(["a", "b", "c"], Json("x"));
  assert(json.hasAllKeys("a", "b", "c"));
  assert(json["a"] == Json("x") && json["b"] == Json("x") && json["c"] == Json("x"));

  json = Json.emptyObject;
  json.set(["a": "A", "b": "B", "c": "C"]);
  assert(json.hasAllKeys("a", "b", "c"));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json = Json.emptyObject;
  json.set(["a": Json("A"), "b": Json("B"), "c": Json("C")]);
  assert(json.hasAllKeys("a", "b", "c"));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  auto newJson = Json.emptyObject;
  newJson.set(json);
  assert(json.hasAllKeys("a", "b", "c"));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));
}
// #endregion set

// #region merge
ref merge(ref Json json, Json map) {
  if (!json.isObject) {
    return json;
  }

  if (!map.isObject) {
    return json;
  }

  map.byKeyValue.each!(kv => json.merge(kv.key, kv.value));
  return json;
}

ref merge(T)(ref Json json, T[string] values) {
  if (!json.isObject) {
    return json;
  }

  values.each!((key, value) => json.merge(key, value));
  return json;
}

ref merge(T)(ref Json json, string[] keys, T value) {
  if (!json.isObject) {
    return json;
  }

  keys.each!(key => json.merge(key, value));
  return json;
}

// 
ref merge(T)(ref Json json, string key, T value) {
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
  assert(json.hasAllKeys("a", "b", "c"));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json = Json.emptyObject;
  json.merge("a", Json("A"));
  json.merge("b", Json("B")).merge("c", Json("C"));
  assert(json.hasAllKeys("a", "b", "c"));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json.merge(["a", "b", "c"], "x");
  assert(json["a"] == Json("x") && json["b"] == Json("x") && json["c"] == Json("x"));

  json = Json.emptyObject;
  json.merge(["a", "b", "c"], Json("x"));
  assert(json.hasAllKeys("a", "b", "c"));
  assert(json["a"] == Json("x") && json["b"] == Json("x") && json["c"] == Json("x"));

  json = Json.emptyObject;
  json.merge(["a": "A", "b": "B", "c": "C"]);
  assert(json.hasAllKeys("a", "b", "c"));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json = Json.emptyObject;
  json.merge(["a": Json("A"), "b": Json("B"), "c": Json("C")]);
  assert(json.hasAllKeys("a", "b", "c"));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  auto newJson = Json.emptyObject;
  newJson.merge(json);
  assert(json.hasAllKeys("a", "b", "c"));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));
}
 */ // #endregion merge

// #region update
ref update(ref Json json, Json map) {
  if (!json.isObject) {
    return json;
  }

  if (!map.isObject) {
    return json;
  }

  map.byKeyValue.each!(kv => json.update(kv.key, kv.value));
  return json;
}

ref update(T)(ref Json json, T[string] values) {
  if (!json.isObject) {
    return json;
  }

  values.each!((key, value) => json.update(key, value));
  return json;
}

ref update(T)(ref Json json, string[] keys, T value) {
  if (!json.isObject) {
    return json;
  }

  keys.each!(key => json.update(key, value));
  return json;
}

// 
ref update(T)(ref Json json, string key, T value) {
  if (!json.isObject) {
    return json;
  }

  if (json.hasKey(key))
    json[key] = value;

  return json;
}

// TODO
/* unittest {
  auto json = Json.emptyObject;
  json.update("a", "A");
  json.update("b", "B").update("c", "C");
  assert(json.hasAllKeys("a", "b", "c"));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json = Json.emptyObject;
  json.update("a", Json("A"));
  json.update("b", Json("B")).update("c", Json("C"));
  assert(json.hasAllKeys("a", "b", "c"));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json.update(["a", "b", "c"], "x");
  assert(json["a"] == Json("x") && json["b"] == Json("x") && json["c"] == Json("x"));

  json = Json.emptyObject;
  json.update(["a", "b", "c"], Json("x"));
  assert(json.hasAllKeys("a", "b", "c"));
  assert(json["a"] == Json("x") && json["b"] == Json("x") && json["c"] == Json("x"));

  json = Json.emptyObject;
  json.update(["a": "A", "b": "B", "c": "C"]);
  assert(json.hasAllKeys("a", "b", "c"));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json = Json.emptyObject;
  json.update(["a": Json("A"), "b": Json("B"), "c": Json("C")]);
  assert(json.hasAllKeys("a", "b", "c"));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  auto newJson = Json.emptyObject;
  newJson.update(json);
  assert(json.hasAllKeys("a", "b", "c"));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));
}
 */ // #endregion update

Json match(K)(Json[K] matchValues, K key, Json defaultValue = Json(null)) {
  return key in matchValues
    ? matchValues[key] : defaultValue;
}

// #region isSet
bool isSet(Json json, string key) {
  return json.isObject
    ? json.byKeyValue.any!(kv => kv.key == key) : false;
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
    Json, T)(ref V[K] items, K[] keys, T value) {
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
    assert(map.length == 6 && map.hasAllKeys("d", "e", "f"));

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

    map.set("d", false);
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
    Json, T)(ref V[K] items, K[] keys, T value) {
    keys
      .each!(key => items.update(key, value));
    return items;
  }
 */
// Returns a new map with updated values for existing keys
/*  ref update(K : string, V:
    Json, T)(ref V[K] items, K key, T value) if (!is(typeof(value) == Json)) {
    return items.update(key, Json(value));
  }

  // Returns a new map with updated values for existing keys
  ref update(K : string, V:
    Json, T)(ref V[K] items, K key, T value) if (!is(typeof(V) == typeof(T))) {
      return items.update(key, Json(value));
  }
 */
unittest {
  Json[string] map = ["a": Json("A"), "b": Json("B"), "c": Json("C")];
  assert(map.length == 3 && map.hasAllKeys(["a", "b", "c"]) && map["a"] == "A");

  /* map.update("a", "x").update("d", "x").update("e", "x").update("f", "x");
    assert(map.length == 3 && !map.hasAnyKey("d", "e", "f") && map["a"] == Json("x"));

    map = ["a": Json("A"), "b": Json("B"), "c": Json("C")]; // Reset map
    map.update(["c", "d", "e"], "x");
    assert(map.length == 3 && !map.hasAnyKey("d", "e", "f") && map["a"] != "x" && map["c"] == Json("x"));

    map = ["a": Json("A"), "b": Json("B"), "c": Json("C")]; // Reset map
    map.update(["a", "b", "c"], "x").update(["d", "e", "f"], "x");
    assert(map.length == 3 && !map.hasAnyKey("d", "e", "f") && map["a"] == Json("x") && map["c"] == Json(
        "x"));

    map = ["a": Json("A"), "b": Json("B"), "c": Json("C")]; // Reset map
    map.update(["c": "x", "d": "x", "e": "x"]);
    assert(map.length == 3 && !map.hasAnyKey("d", "e", "f") && map["a"] != "x" && map["c"] == Json(
        "x"));

    map = ["a": Json("A"), "b": Json("B"), "c": Json("C")]; // Reset map
    map.update(["c": "x", "d": "x", "e": "x"], "c", "e");
    assert(map.length == 3 && !map.hasAnyKey("d", "e", "f") && map["a"] != "x" && map["c"] == Json(
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
    Json, T)(ref V[K] items, K[] keys, T value) {
    keys
      .each!(key => items.merge(key, value));
    return items;
  }

  // Returns a new map with updated values for existing keys
  ref merge(K : string, V:
    Json, T)(ref V[K] items, K key, T value) if (!is(typeof(value) == Json)) {
    return items.merge(key, Json(value));
  }

  // Returns a new map with updated values for existing keys
  ref merge(K : string, V:
    Json, T)(ref V[K] items, K key, T value) if (!is(typeof(V) == typeof(T))) {
    return items.merge(key, Json(value));
  } */

unittest {
  Json[string] map = ["a": Json("A"), "b": Json("B"), "c": Json("C")];
  assert(map.length == 3 && map.hasAllKeys("a", "b", "c") && map["a"] == "A");

  /* map.merge("a", "x").merge("d", "x").merge("e", "x").merge("f", "x");
    assert(map.length == 6 && map.hasAnyKey("d", "e", "f") && map["e"] == Json("x"));

    map = ["a": Json("A"), "b": Json("B"), "c": Json("C")]; // Reset map
    map.merge(["c", "d", "e"], "x");
    assert(map.length == 5 && map.hasAnyKey("d", "e", "f") && map["a"] != Json("x") && map["d"] == Json("x"));

    map = ["a": Json("A"), "b": Json("B"), "c": Json("C")]; // Reset map
    map.merge(["a", "b", "c"], "x").merge(["d", "e", "f"], "x");
    assert(map.length == 6 && map.hasAnyKey("d", "e", "f") && map["a"] != Json("x") && map["d"] == Json(
        "x"));

    map = ["a": Json("A"), "b": Json("B"), "c": Json("C")]; // Reset map
    map.merge(["c": "x", "d": "x", "e": "x"]);
    assert(map.length == 5 && map.hasAnyKey("d", "e", "f") && map["a"] != "x" && map["d"] == Json(
        "x"));

    map = ["a": Json("A"), "b": Json("B"), "c": Json("C")]; // Reset map
    map.merge(["c": "x", "d": "x", "e": "x"], "c", "e");
    assert(map.length == 4 && map.hasAnyKey("d", "e", "f") && map["a"] != "x" && map["e"] == Json(
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
  STRINGAA results;
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

T[string] set(T : Json, V)(T[string] items, string key, V value) if (!is(V == T)) {
  items.set(key, value.toJson);
  return items;
}

T[string] merge(T : Json, V)(T[string] items, string key, V value) if (!is(V == T)) {
  items.merge(key, value.toJson);
  return items;
}

T[string] update(T : Json, V)(T[string] items, string key, V value) if (!is(V == T)) {
  items.update(key, value.toJson);
  return items;
}

string[string] merge(string[string] items, string key, Json value) {
  return items.merge(key, value.toString);
}

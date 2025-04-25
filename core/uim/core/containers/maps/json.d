/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.core.containers.maps.json;

mixin(Version!("test_uim_core"));

import uim.core;
@safe:

alias JMAP = Json[string];

// #region set
  // returns a updated map with new values
/*   ref set(K : string, V:Json, T:Json)(ref V[K] items, T[K] others, K[] keys...) if (is(typeof(T) == Json)) {
    return set(items, others, keys.dup);
  }

  // Returns a new map with updated values for existing keys
  ref set(K : string, V:Json, T:Json)(ref V[K] items, T[K] others, K[] keys = null) if (is(typeof(T) == Json)) {
    keys.length == 0
      ? others
      .each!((key, value) => items.set(key, value)) : keys
      .filter!(key => key in others)
      .each!(key => items.set(key, others[key]));

    return items;
  } */

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
 */  }
// #endregion set

// #region update
/*   // Returns a updated map with updated of existing keys and new values
  ref update(K : string, V:
    Json, T)(ref V[K] items, T[K] merges, K[] keys...) {
    return update(items, merges, keys.dup);
  }

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
    assert(map.length == 3 && map.hasAllKeys("a", "b", "c") && map["a"] == "A");

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
  /* ref merge(K : string, V:
    Json, T)(ref V[K] items, T[K] merges, K[] keys...) if (!is(typeof(T) == Json)) {
    return merge(items, merges, keys.dup);
  }

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

// #region ifNull
Json ifNull(K:string, V:Json, T)(ref V[K] items, K key, T defaultValue) {
  return items.isNull(key) ? Json(defaultValue) : items[key];
}

Json ifNull(K:string, V:Json, T:Json)(ref V[K] items, K key, T defaultValue) {
  return items.isNull(key) ? defaultValue : items[key];
}
unittest {
  Json[string] map = ["a": Json("A"), "b": Json("B"), "c": Json("C")];
  assert(map.length == 3);

}
// #endregion ifNull


// #region Getter
Json getJson(Json[string] values, string key) {
  key = key.strip;
  
  return values.hasKey(key)
    ? values[key]
    : Json(null);
}

unittest {
  Json[string] map = ["a": Json("A"), "b": Json(true), "c": Json(1), "d": Json(1.1)];
  assert(map.length == 4);

  assert(map.getJson("a") == Json("A"));
}

bool getBoolean(Json[string] values, string key, bool defaultValue = false) {
  auto json = getJson(values, key);
  return !(json == Json(null))
    ? json.get!bool : defaultValue;
}
unittest {
  Json[string] map = ["a": Json("A"), "b": Json(true), "c": Json(1), "d": Json(1.1)];
  assert(map.length == 4);

  assert(map.getBoolean("b") == true);
}

int getInteger(Json[string] values, string key, int defaultValue = 0) {
  auto json = getJson(values, key);
  return !(json == Json(null))
    ? json.get!int : defaultValue;
}
unittest {
  Json[string] map = ["a": Json("A"), "b": Json(true), "c": Json(1), "d": Json(1.1)];
  assert(map.length == 4);

  assert(map.getInteger("c") == 1);
}

long getLong(Json[string] values, string key, long defaultValue = 0) {
  auto json = getJson(values, key);
  return !(json == Json(null))
    ? json.get!long : defaultValue;
}
unittest {
  Json[string] map = ["a": Json("A"), "b": Json(true), "c": Json(1), "d": Json(1.1)];
  assert(map.length == 4);

  assert(map.getLong("c") == 1);
}

double getDouble(Json[string] items, string key, double defaultValue = 0.0) {
  auto json = items.get(key, Json(null));
  return !(json == Json(null))
    ? json.get!double : defaultValue;
}
unittest {
  Json[string] map = ["a": Json("A"), "b": Json(true), "c": Json(1), "d": Json(1.1)];
  assert(map.length == 4);

  assert(map.getDouble("d") == 1.1);
}

string getString(Json[string] items, string key, string defaultValue = null) {
  auto json = items.get(key, Json(null));
  return !(json == Json(null))
    ? json.get!string : defaultValue;
}
unittest {
  Json[string] map = ["a": Json("A"), "b": Json(true), "c": Json(1), "d": Json(1.1)];
  assert(map.length == 4);

  assert(map.getString("a") == "A");
}

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

Json getJson(Json[string] map, string key, Json defaultValue = Json(null)) {
  return key in map
    ? map[key] : defaultValue;
}

// #region getArray
Json[] getArray(Json[string] map, string key, Json[] defaultValue = null) {
  return map.isArray(key)
    ? map[key].get!(Json[])
    : defaultValue;
}
// #endregion getArray

// #region getMap
Json[string] getMap(Json[string] map, string key, Json[string] defaultValue = null) {
  return map.isObject(key)
    ? map[key].get!(Json[string]) : defaultValue;
}

unittest {
  Json json = Json.emptyObject;
  json["a"] = "A";
  json["one"] = 1;

  Json[string] jsonMain = ["x": json];

  // assert(jsonMain.getMap("x").getString("a") == "A");
  // assert(jsonMain.getMap("x").getString("b") != "A");
  // assert(jsonMain.getMap("x").getInteger("one") == 1);
  // assert(jsonMain.getMap("x").getInteger("oNe") != 1);

  // TODO 
  /*    // assert(jsonMain.getMap("x")["A"].getString == "A");
    // assert(jsonMain.getMap("x")["one"].getInteger == 1);
 */
}
// #endregion getMap
// #endregion Getter

// #region convert
Json[string] toJsonMap(bool[string] values, string[] excludeKeys = null) {
  Json[string] result;
  values.byKeyValue
    .filter!(kv => !excludeKeys.any!(key => key in values))
    .each!(kv => result[kv.key] = Json(kv.value));
  return result;
}

Json[string] toJsonMap(long[string] values, string[] excludeKeys = null) {
  Json[string] result;
  values.byKeyValue
    .filter!(kv => !excludeKeys.any!(key => key in values))
    .each!(kv => result[kv.key] = Json(kv.value));
  return result;
}

Json[string] toJsonMap(double[string] values, string[] excludeKeys = null) {
  Json[string] result;
  values.byKeyValue
    .filter!(kv => !excludeKeys.any!(key => key in values))
    .each!(kv => result[kv.key] = Json(kv.value));
  return result;
}

Json[string] toJsonMap(string[string] items, string[] excludeKeys = null) {
  Json[string] result;
  items.byKeyValue
    .filter!(item => !excludeKeys.hasValue(item.key))
    .each!(item => result[item.key] = Json(item.value));
  return result;
}

unittest {
  // assert(["a": "A", "b": "B"].toJsonMap.length == 2);
  // assert(["a": "A", "b": "B"].toJsonMap.getString("a") == "A");
  // assert(["a": "A", "b": "B"].toJsonMap(["b"]).length == 1);
  // assert(["a": "A", "b": "B"].toJsonMap(["b"]).getString("a") == "A");
}
// #endregion convert

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



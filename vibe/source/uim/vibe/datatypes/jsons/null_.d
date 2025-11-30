/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.null_;

import uim.vibe;
mixin(Version!("test_uim_vibe"));

@safe:

// #region Null
/// Create a null Json value for the specified type.
T Null(T : Json[string])() {
  return null;
}

/// Create a null Json array value.
T Null(T : Json[])() {
  return null;
}

/// Create a null Json value.
T Null(T : Json)() if (is(T == Json)) {
  return Json(null);
}

unittest {
  // Test Json(null)[string]
  Json[string] jsMap = ["a": Json("b")];
  jsMap = Null!(Json[string]);
  assert(Null!(Json[string]).isNull, "Json(null)[string] should return null");
  assert(jsMap.isNull, "Json(null)[string] should return null");

  // Test Json(null)[]
  Json[] jsArr = [Json("a"), Json("b")];
  jsArr = Null!(Json[]);
  assert(Null!(Json[]).isNull, "Json(null)[] should return null");
  assert(jsArr.isNull, "Json(null)[] should return null");

  // Test Json(null)
  Json js = Json("test");
  js = Json(null);
  assert(Json(null).isNull, "Json(null) should return Json(null)");
  assert(js.isNull, "Json(null) should return Json(null)");
}
// #endregion Null

// #region is
// Check if json value is null
// #region Json[string]
bool isAllNull(Json[string] map, bool strict = true) {
  if (map is null) {
    return true;
  }
  if (map.length == 0) {
    return false;
  }
  return map.byValue.all!(value => value.isNull(strict));
}

bool isAllNull(Json[string] map, string[] keys, bool strict = true) {
  if (map is null) {
    return true;
  }
  return keys.all!(key => map.isNull(key, strict));
}

bool isAnyNull(Json[string] map, bool strict = true) {
  if (map is null) {
    return true;
  }
  return map.byValue.any!(value => value.isNull(strict));
}

bool isAnyNull(Json[string] map, string[] keys, bool strict = true) {
  if (map is null) {
    return true;
  }
  return keys.any!(index => map.isNull(index));
}

bool isNull(Json[string] map) {
  return (map is null);
}

bool isNull(Json[string] map, string key, bool strict = true) {
  if (map.isNull) {
    return true;
  }
  return key in map && map[key].isNull(strict);
}

unittest {
  // Test isAllNull(Json[string])
  Json[string] nullMap;
  assert(isAllNull(nullMap), "null map should be all null");

  Json[string] map1 = ["a": Json(null), "b": Json(null)];
  assert(isAllNull(map1), "all null values should return true");

  Json[string] map2 = ["a": Json(null), "b": Json("x")];
  assert(!isAllNull(map2), "not all null values should return false");

  // Test isAllNull(Json[string], string[])
  string[] keys1 = ["a", "b"];
  assert(isAllNull(map1, keys1), "all keys null should return true");
  assert(!isAllNull(map2, keys1), "one key not null should return false");

  string[] keys2 = ["a"];
  assert(isAllNull(map2, keys2), "single key null should return true");

  // Test isAnyNull(Json[string])
  assert(isAnyNull(nullMap), "null map should be any null");
  assert(isAnyNull(map1), "all null values should return true");
  assert(isAnyNull(map2), "one null value should return true");

  Json[string] map3 = ["a": Json("x"), "b": Json("y")];
  assert(!isAnyNull(map3), "no null values should return false");

  // Test isAnyNull(Json[string], string[])
  assert(isAnyNull(map2, keys1), "one key null should return true");
  assert(!isAnyNull(map3, keys1), "no keys null should return false");

  // Test isNull(Json[string], string)
  assert(isNull(nullMap, "a"), "null map should be null for any key");
  assert(isNull(map1, "a"), "key with null value should be null");
  assert(!isNull(map2, "b"), "key with non-null value should not be null");
  assert(!isNull(map2, "z"), "missing key should not be null");
}
// #endregion Json[string]

// #region Json[]
bool isAllNull(Json[] list, bool strict = true) {
  return list.isNull
    ? true
    : list.all!(value => value.isNull(strict));
}

bool isAllNull(Json[] list, size_t[] indices, bool strict = true) {
  return list.isNull
    ? true
    : indices.all!(index => list.isNull(index, strict));
}

bool isAnyNull(Json[] list, bool strict = true) {
  return list.isNull
    ? true
    : list.any!(value => value.isNull(strict));
}

bool isAnyNull(Json[] list, size_t[] indices, bool strict = true) {
  return list.isNull
    ? true
    : indices.any!(index => list.isNull(index, strict));
}

bool isNull(Json[] list) {
  return (list is null); 
}  

bool isNull(Json[] list, size_t index, bool strict = true) {
  if (list is null) {
    return true;
  }

  if (index >= list.length) {
    return true;
  }

  // list.length > index
  return list[index].isNull(strict);
}

unittest {
  // Test isAllNull(Json[] list)
  Json[] nullList;
  assert(isAllNull(nullList), "null list should be all null");

  Json[] emptyList = [];
  assert(isAllNull(emptyList) == true, "empty list should be all null (vacuously true)");

  Json[] allNulls = [Json(null), Json(null)];
  assert(isAllNull(allNulls), "list with all Json(null) should be all null");

  Json[] someNulls = [Json(null), Json("a")];
  assert(!isAllNull(someNulls), "list with some non-null should not be all null");

  // Test isAllNull(Json[] list, size_t[] indices)
  size_t[] indices = [0, 1];
  assert(isAllNull(allNulls, indices), "indices all null");
  assert(!isAllNull(someNulls, indices), "indices not all null");

  size_t[] singleIndex = [0];
  assert(isAllNull(someNulls, singleIndex), "single index null");

  // Test isAnyNull(Json[] list)
  assert(isAnyNull(nullList), "null list should be any null");
  assert(isAnyNull(allNulls), "all nulls should be any null");
  assert(isAnyNull(someNulls), "some nulls should be any null");

  Json[] noNulls = [Json("a"), Json("b")];
  assert(!isAnyNull(noNulls), "no nulls should not be any null");

  // Test isAnyNull(Json[] list, size_t[] indices)
  assert(isAnyNull(someNulls, indices), "indices with some null should be any null");
  assert(!isAnyNull(noNulls, indices), "indices with no null should not be any null");

  // Test isNull(Json[] list, size_t index)
  assert(isNull(nullList, 0), "null list should be null for any index");
  assert(isNull(allNulls, 0), "allNulls[0] should be null");
  assert(!isNull(noNulls, 0), "noNulls[0] should not be null");
  assert(isNull(allNulls, 2), "out of bounds index should be null");
  assert(isNull(someNulls, 0), "someNulls[0] is null");
  assert(!isNull(someNulls, 1), "someNulls[1] is not null");
}
// #endregion Json[]

// #region Json
bool isAllNull(Json json, bool strict = true) {
  if (json == Json(null)) {
    return true;
  }
  if (json.isObject) {
    return isAllNull(json.to!(Json[string]), strict);
  }

  if (json.isArray) {
    return isAllNull(json.to!(Json[]), strict);
  }

  return json.isNull(strict);
}

bool isAllNull(Json json, string[] keys, bool strict = true) {
  if (json == Json(null)) {
    return true;
  }
  return keys.all!(key => json.isNull(key, strict));
}

bool isAnyNull(Json json, bool strict = true) {
  if (json == Json(null)) {
    return true;
  }
  if (json.isObject) {
    return isAnyNull(json, strict);
  }

  if (json.isArray) {
    return isAnyNull(json, strict);
  }

  return json.isNull(strict);
}

bool isAnyNull(Json json, string[] keys, bool strict = true) {
  if (json == Json(null)) {
    return true;
  }
  return keys.any!(key => json.isNull(key, strict));
}

bool isNull(Json json, string[] path, bool strict = true) {
  if (json == Json(null)) {
    return true;
  }
  if (!json.isObject) {
    return false;
  }

  if (path.length == 0) {
    return json.isNull(strict);
  }

  auto key = path[0];
  return path.length == 1
    ? json.isNull(key, strict) : json.hasKey(key) && json[key].isNull(path[1 .. $], strict);
}

bool isNull(Json json, string key, bool strict = true) {
  if (json == Json(null)) {
    return true;
  }

  if (!json.isObject) {
    return false;
  }

  return (key !in json)
    ? true : json[key].isNull(strict);
}

bool isNull(Json json, string[] path) {
  if (json == Json(null)) {
    return true;
  }

  if (json.isNull) {
    return true;
  }

  if (path.length == 0) {
    return false;
  }

  auto firstKey = path[0];
  if (json.isNull(firstKey)) {
    return true;
  }

  return path.length > 1
    ? isNull(json[firstKey], path[1 .. $]) : false;
}

bool isNull(Json json, bool strict = true) {
  if (json == Json(null)) {
    return true;
  }

  if (!strict) {
    if (json.isNull) {
      return true;
    }

    if (json.isString) {
      auto val = json.getString.toLower;
      return (val == "null") || (val == "none") || (val == "nil") ||
        (val == "undefined") || (val == "empty") || (val == "void");
    }

    if (json.isInteger) {
      return json.get!int == 0;
    }

    if (json.isDouble) {
      return json.get!double == 0.0;
    }
  }

  return json == Json(null); // null value
}

unittest {
  assert(Json(null).isNull);
  assert(!Json.emptyObject.isNull);
  assert(!Json.emptyArray.isNull);

  auto json = parseJsonString(`{"a": "b", "c": {"d": 1}, "e": ["f", {"g": "h"}]}`);
  assert(json.isNull("x"));
  assert(!json.isNull("a"));

  assert(json.isNull(["x"]));
  assert(!json.isNull(["a"]));

  assert(json.isAllNull(["x", "y"]));
  assert(!json.isAllNull(["a", "y"]));
  assert(json.isAnyNull(["x", "y"]));
  assert(!json.isAnyNull(["a", "c"]));
}
// #endregion is

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
bool isAllNull(Json[string] map) {
  if (map is null) {
    return true;
  }
  if (map.length == 0) {
    return false;
  }
  return map.byValue.all!(value => value.isNull);
}

b

bool isNull(Json[string] map, string key) {
  if (map.isNull) {
    return true;
  }
  return key in map && map[key].isNull;
}



// #region Json[]
bool isAllNull(Json[] list) {
  return list.isNull
    ? true
    : list.all!(value => value.isNull(strict));
}

bool isAllNull(Json[] list, size_t[] indices) {
  return list.isNull
    ? true
    : indices.all!(index => list.isNull(index, strict));
}

bool isAnyNull(Json[] list) {
  return list.isNull
    ? true
    : list.any!(value => value.isNull(strict));
}

bool isAnyNull(Json[] list, size_t[] indices) {
  return list.isNull
    ? true
    : indices.any!(index => list.isNull(index, strict));
}

bool isNull(Json[] list) {
  return (list is null); 
}  

bool isNull(Json[] list, size_t index) {
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
bool isAllNull(Json json) {
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

bool isAllNull(Json json, string[] keys) {
  if (json == Json(null)) {
    return true;
  }
  return keys.all!(key => json.isNull(key, strict));
}

bool isAnyNull(Json json) {
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

bool isAnyNull(Json json, string[] keys) {
  if (json == Json(null)) {
    return true;
  }
  return keys.any!(key => json.isNull(key, strict));
}

bool isNull(Json json, string[] path) {
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

// #endregion is

/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.data.json.null_;

mixin(Version!("test_uim_vibe"));

import uim.vibe;
@safe:

// #region Null
T Null(T:Json[string])() {
  return null;
}

T Null(T:Json[])() {
  return null;
}

T Null(T:Json)() if (is(T == Json)) {
  return Json(null);
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

bool isNull(Json[string] map, string key, bool strict = true) {
  if (map is null) {
    return true;
  }
  return key in map && map[key].isNull(strict);
};
// #endregion Json[string]

// #region Json[]
bool isAllNull(Json[] list, bool strict = true) {
  if (list is null) {
    return true;
  }
  return list.all!(value => value.isNull(strict));
}

bool isAllNull(Json[] list, size_t[] indices, bool strict = true) {
  if (list is null) {
    return true;
  }
  return indices.all!(index => list.isNull(index, strict));
}

bool isAnyNull(Json[] list, bool strict = true) {
  if (list is null) {
    return true;
  }
  return list.any!(value => value.isNull(strict));
}

bool isAnyNull(Json[] list, size_t[] indices, bool strict = true) {
  if (list is null) {
    return true;
  }
  return indices.any!(index => list.isNull(index, strict));
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
    ? json.isNull(key, strict) 
    : json.hasKey(key) && json[key].isNull(path[1 .. $], strict);
}

bool isNull(Json json, string key, bool strict = true) {
  if (json == Json(null)) {
    return true;
  }

  if (!json.isObject) {
    return false;
  }

  return (key !in json) 
    ? true
    : json[key].isNull(strict);
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
    ? isNull(json[firstKey], path[1..$]) 
    : false;
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
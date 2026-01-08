module uim.root.datatypes.jsons.has;

import uim.root;

mixin(ShowModule!());

@safe:

// #region value
bool hasAllValue(T)(Json json, T[] values) {
  return values.all!(value => json.hasValue(value));
}
/// 
unittest {
  mixin(ShowTest!"Testing hasAllValue for Json with values");

  Json json = [
    "a": Json(1),
    "b": Json(2),
    "c": Json(3)
  ].toJson;

  assert(hasAllValue(json, [1, 2]));
  assert(!hasAllValue(json, [1, 4]));
}

bool hasAnyValue(T)(Json json, T[] values) {
  return values.any!(value => json.hasValue(value));
}
/// 
unittest {
  mixin(ShowTest!"Testing hasAnyValue for Json with values");

  Json json = [
    "a": Json(1),
    "b": Json(2),
    "c": Json(3)
  ].toJson;

  assert(hasAnyValue(json, [2, 4]));
  assert(!hasAnyValue(json, [4, 5]));
}

bool hasValue(T)(Json json, T value) {
  if (json == Json(null)) {
    return false;
  }

  if (json.isArray) {
    return json.byValue
      .any!(v => hasValue(v, value));
  } else if (json.isObject) {
    return json.byValue.any!(v => hasValue(v, value));
  }

  return json == value.toJson;
}
/// 
unittest {
  mixin(ShowTest!"Testing hasValue for Json with value");

  Json json = [
    "a": Json(1),
    "b": [
      Json(2), Json(3), [
        "c": Json(4)
      ].toJson
    ].toJson,
    "d": Json(5)
  ].toJson;

  assert(hasValue(json, 4));
  assert(!hasValue(json, 6));
}
// #endregion value

// #region path
// #region hasAll
bool hasAllPath(Json json, string[][] paths) {
  if (!json.isObject || paths.length == 0) {
    return false;
  }

  return paths.all!(path => json.hasPath(path));
}
/// 
unittest {
  mixin(ShowTest!"Testing hasAllPath for Json with paths");

  Json json = [
    "a": [
      "b": [
        "c": 123.toJson
      ].toJson
    ].toJson,
    "x": 456.toJson
  ].toJson;

  assert(json.hasAllPath([["a", "b", "c"], ["x"]]));
  assert(!json.hasAllPath([["a", "b", "d"], ["x"]]));

  Json json2 = [
    "a": [
      "b": [
        "c": Json(null)
      ].toJson
    ].toJson,
    "x": Json(null)
  ].toJson;

  assert(json2.hasAllPath([["a", "b", "c"], ["x"]]));
  assert(!json2.hasAllPath([["a", "b", "d"], ["x"]]));
}
// #endregion hasAll

// #region hasAny
bool hasAnyPath(Json json, string[][] paths) {
  if (!json.isObject || paths.length == 0) {
    return false;
  }

  return paths.any!(path => hasPath(json, path));
}
/// 
unittest {
  mixin(ShowTest!"Testing hasAnyPath for Json with paths");

  Json json = [
    "a": [
      "b": [
        "c": 123.toJson
      ].toJson
    ].toJson,
    "x": 456.toJson
  ].toJson;

  assert(json.hasAnyPath([["a", "b", "c"], ["y"]]));
  assert(!json.hasAnyPath([["a", "b", "d"], ["y"]]));
}
// #endregion hasAny

// #region has
/** 
  * Checks if the given JSON value has the specified path.
  *
  * Params:
  *   json = The JSON value to check.
  *   path = An array of keys representing the path to check.
  *
  * Returns:
  *   `true` if the JSON value has the specified path, `false` otherwise.
  */
bool hasPath(Json json, string[] path) {
  if (!json.isObject || path.length == 0) {
    return false;
  } 
  
  auto first = hasKey(json, path[0]);
  if (!first) {
    return false;
  }

  if (path.length == 1) {
    return first;
  }

  return json[path[0]].isObject ? hasPath(json[path[0]], path[1 .. $]) : false;
}
/// 
unittest {
  mixin(ShowTest!"Testing hasPath for Json with path");

  Json json = [
    "a": [
      "b": [
        "c": 123.toJson
      ].toJson
    ].toJson,
    "x": 456.toJson
  ].toJson;

  assert(hasPath(json, ["a", "b", "c"]));
  assert(!hasPath(json, ["a", "b", "d"]));
}
// #endregion has

// #region Json[string]
bool hasPath(Json[string] map, string[] path) {
  import uim.root.containers.associative.maps.has;

  if (map.length == 0 || path.length == 0) {
    return false;
  }

  auto keyFound = (path[0] in map) ? true : false;
  if (path.length == 1) {
    return keyFound;
  }

  if (!keyFound) {
    return false;
  }
  
  auto value = map[path[0]];
  return path.length > 1 && value.isObject ? value.hasPath(path[1 .. $]) : false;
}
/// 
unittest {
  mixin(ShowTest!"Testing hasPath for Json with path");

  Json json = [
    "a": [
      "b": [
        "c": 123.toJson
      ].toJson
    ].toJson,
    "x": 456.toJson
  ].toJson;

  assert(hasPath(json, ["a", "b", "c"]));
  assert(!hasPath(json, ["a", "b", "d"]));
}
// #endregion Json[string]

// #region key
// Check if json has key
bool hasAllKey(Json json, string[] keys) {
  if (!json.isObject || keys.length == 0) {
    return false;
  }

  return keys.all!(key => hasKey(json, key));
}
/// 
unittest {
  mixin(ShowTest!"Testing hasAllKey for Json with keys");

  Json json = [
    "a": Json(1),
    "b": Json(2),
    "c": Json(3)
  ].toJson;

  assert(hasAllKey(json, ["a", "b"]));
  assert(!hasAllKey(json, ["a", "d"]));
}

/// Check if Json has key
bool hasAnyKey(Json json, string[] keys) {
  return keys.any!(key => hasKey(json, key));
}
/// 
unittest {
  mixin(ShowTest!"Testing hasAnyKey for Json with keys");

  Json json = [
    "a": Json(1),
    "b": Json(2),
    "c": Json(3)
  ].toJson;

  assert(hasAnyKey(json, ["b", "d"]));
  assert(!hasAnyKey(json, ["d", "e"]));
}

// #region hasKey
/** 
  * Checks if the given JSON value has the specified key.
  *
  * Params:
  *   json = The JSON value to check.
  *   key = The key to check for.
  *
  * Returns:
  *   `true` if the JSON value has the specified key, `false` otherwise.
  */
bool hasKey(Json json, string key) {
  return json.isObject && key in json;
}
///
unittest {
  mixin(ShowTest!"Testing hasKey for Json with key");

  // Non-object JSON -> always false
  auto json1 = Json(1);
  assert(!hasKey(json1, "foo"));
  assert(!hasKey(json1, ""));

  // Object with keys -> true for present keys, false for absent
  auto json2 = Json(["a": Json(1), "": Json(2)]);
  assert(hasKey(json2, "a"));
  assert(hasKey(json2, ""));
  assert(!hasKey(json2, "b"));

  // Keys are exact (case-sensitive)
  auto json3 = Json(["Key": Json(1)]);
  assert(hasKey(json3, "Key"));
  assert(!hasKey(json3, "key"));

  // Keys with special characters
  auto json4 = Json(["weird:key!": Json(42)]);
  assert(hasKey(json4, "weird:key!"));
}
// #endregion hasKey

/*
bool hasKey(Json[string] map, string key) {
  return (key in map) ? true : false;
}
*/ 

// #endregion key

bool hasKeyValue(Json json, string key, Json value) {
  if (!json.isObject || !json.hasKey(key)) {
    return false;
  }

  return json[key] == value;
}
/// 
unittest {
  mixin(ShowTest!"Testing hasKeyValue for Json with key and value");

  Json json = [
    "a": Json(1),
    "b": Json(2),
    "c": Json(3)
  ].toJson;

  assert(hasKeyValue(json, "a", Json(1)));
  assert(!hasKeyValue(json, "b", Json(3)));
  assert(!hasKeyValue(json, "d", Json(4)));
}
// #endregion has

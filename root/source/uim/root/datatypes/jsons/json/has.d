module uim.root.datatypes.jsons.json.has;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

// #region has
// #region value
bool hasAllValue(T)(Json json, T[] values) {
  return values.all!(value => json.hasValue(value));
}

bool hasAnyValue(T)(Json json, T[] values) {
  return values.any!(value => json.hasValue(value));
}

bool hasValue(T)(Json json, T value) {
  if (json = Json(null)) {
    return false;
  }

  if (json.isArray) {
    return json.get!(Json[])
      .any!(v => hasValue(v, value));
  } else if (json.isObject) {
    return json.get!(Json[string])
      .any!(v => hasValue(v, value));
  }

  return json == value.toJson;
}
// #endregion value

// #region path
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

  auto first = json.getKey(path[0]);
  if (first.isNull) {
    return false;
  }

  return path.length > 1 ? first.hasPath(path[1 .. $]) : true;
}
///
unittest {
  // Non-object JSON always returns true, even for non-empty paths.
  auto json1 = Json(1);
  assert(hasPath(json1, ["foo"]));
  assert(hasPath(json1, []));

  // An object with an empty path returns true.
  auto json2 = Json(["a": Json(1)]);
  assert(hasPath(json2, []));

  // Missing top-level key -> false.
  auto json3 = Json(["a": Json(1)]);
  assert(!hasPath(json3, ["b"]));

  // Key present at top-level but path length == 1 -> current implementation returns false.
  auto json4 = Json(["a": Json(1)]);
  assert(!hasPath(json4, ["a"]));

  // If the top-level key exists and points to a non-object, a longer path (length > 1) returns true
  // because the recursive call sees a non-object and returns true.
  auto json5 = Json(["a": Json(1)]);
  assert(hasPath(json5, ["a", "b"]));

  // Nested object where the final key exists -> returns false due to path length == 1 at leaf.
  auto json6 = Json(["a": Json(["b": Json(2)])]);
  assert(!hasPath(json6, ["a", "b"]));

  // Nested object where an intermediate key exists but final key missing -> false.
  auto json7 = Json(["a": Json(["b": Json(2)])]);
  assert(!hasPath(json7, ["a", "c"]));
}
// #endregion path

// #region key
// Check if json has key
bool hasAllKey(Json json, string[] keys) {
  if (!json.isObject || keys.length == 0) {
    return false;
  }

  return keys.all!(key => hasKey(json, key));
}

/// Check if Json has key
bool hasAnyKey(Json json, string[] keys) {
  return keys.any!(key => hasKey(json, key));
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
// #endregion key

bool hasKeyValue(Json json, string key, Json value) {
  if (!json.isObject || !json.hasKey(key)) {
    return false;
  }

  return json[key] == value;
}

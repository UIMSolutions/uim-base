module uim.vibe.datatypes.jsons.json.has;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

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
    return json.get!(Json[]).any!(v => hasValue(v, value));
  } else if (json.isObject) {
    return json.get!(Json[string]).any!(v => hasValue(v, value));
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
    return true;
  }

  if (!json.hasKey(path[0])) {
    return false;
  }

  return path.length > 1 && json[path[0]].hasPath(path[1 .. $]);
}
// #endregion path

// #endregion key
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
// #endregion key




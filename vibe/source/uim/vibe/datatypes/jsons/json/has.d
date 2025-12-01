module uim.vibe.datatypes.jsons.json.has;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

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
    return true;
  }

  if (!json.hasKey(path[0])) {
    return false;
  }

  return path.length > 1 && json[path[0]].hasPath(path[1 .. $]);
}

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
// #endregion has

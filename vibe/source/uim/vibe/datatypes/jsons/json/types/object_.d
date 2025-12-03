module uim.vibe.datatypes.jsons.json.types.object_;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region path
// #region all
bool allObject(Json json, string[][] paths) {
  return paths.all!(path => json.isObject(path));
}
// #endregion all

// #region any
bool anyObject(Json json, string[][] paths) {
  return paths.any!(path => json.isObject(path));
}
// #endregion any

// #region is
bool isObject(Json json, string[] path) {
  if (json.isObject || path.length == 0) {
    return true;
  }

  auto firstKey = path[0];
  if (json.isObject(firstKey)) {
    return true;
  }

  return path.length > 1 && json[firstKey].isObject(path[1 .. $]);
}
// #endregion is
// #endregion path

// #region key
// #region all
bool allObject(Json json, string[] keys) {
  return keys.all!(key => json.isObject(key));
}
// #endregion all

// #region any
bool anyObject(Json json, string[] keys) {
  return keys.any!(key => json.isObject(key));
}
// #endregion any

// #region is
bool isObject(Json json, string key) {
  if (!json.isObject) {
    return false;
  }

  return key in json && json[key].isObject;
}
// #endregion is
// #endregion key

// #region scalar
bool isObject(Json json) {
  return (json.type == Json.Type.object);
}
// #endregion scalar

module uim.vibe.datatypes.jsons.json.types.object_;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region path
// #region all
bool isAllObject(Json json, string[][] paths) {
  return paths.all!(path => json.isObject(path));
}
// #endregion all

// #region any
bool isAnyObject(Json json, string[][] paths) {
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
bool isAllObject(Json json, string[] keys) {
  return keys.all!(key => json.isObject(key));
}
// #endregion all

// #region any
bool isAnyObject(Json json, string[] keys) {
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

// #region get
Json[string] getObject(Json json, size_t index, Json[string] defaultValue = null) {
  return json.isObject(index) ? json[index].get!(Json[string]) : defaultValue;
}

Json[string] getObject(Json json, string key, Json[string] defaultValue = null) {
  return json.isObject(key) ? json[key].get!(Json[string]) : defaultValue;
}

Json[string] getObject(Json json, Json[string] defaultValue = null) {
  return json.isObject ? json.get!(Json[string]) : defaultValue;
}
// #endregion get
// #endregion scalar
module uim.vibe.datatypes.jsons.json.arrays.is_;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region path
// #region all
bool isAllArray(Json json, string[][] paths) {
  return paths.all!(path => json.isArray(path));
}
// #endregion all

// #region any
bool isAnyArray(Json json, string[][] paths) {
  return paths.any!(path => json.isArray(path));
}
// #endregion any

// #region is
bool isArray(Json json, string[] path) {
  if (json.isArray || path.length == 0) {
    return true;
  }

  auto firstKey = path[0];
  if (json.isArray(firstKey)) {
    return true;
  }

  return path.length > 1 && json[firstKey].isArray(path[1 .. $]);
}
// #endregion is
// #endregion path

// #region key
// #region all
bool isAllArray(Json json, string[] keys) {
  return keys.all!(key => json.isArray(key));
}
// #endregion all

// #region any
bool isAnyArray(Json json, string[] keys) {
  return keys.any!(key => json.isArray(key));
}
// #endregion any

// #region is
bool isArray(Json json, string key) {
  return json.hasKey(key) && json[key].isArray;
}
// #endregion is
// #endregion key

// #region scalar
bool isArray(Json json) {
  return (json.type == Json.Type.array);
}
// #endregion scalar

// #region get
Json[] getArray(Json json, size_t index, Json[] defaultValue = null) {
  return json.isArray(index) ? json[index].get!(Json[]) : defaultValue;
}

Json[] getArray(Json json, string key, Json[] defaultValue = null) {
  return json.isArray(key) ? json[key].get!(Json) : defaultValue;
}

Json[] getArray(Json json, Json[] defaultValue = null) {
  return json.isArray ? json.get!(Json[]) : defaultValue;
}
// #endregion get
// #endregion scalar
module uim.root.datatypes.jsons.types.arrays.get;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

// #region Json[]
Json getArray(Json[] jsons, size_t index, Json defaultValue = null) {
  return jsons.getValue(index).isArray() ? jsons[index] : defaultValue;
}
// #endregion Json[]

// #region Json[string]
Json getArray(Json[string] map, string[] path, Json defaultValue = null) {
  return map.getValue(path).isArray ? map.getValue(path) : defaultValue;
}

Json getArray(Json[string] map, string key, Json defaultValue = null) {
  return map.getValue(key).isArray ? map.getValue(key) : defaultValue;
}
// #endregion Json[string]

// #region Json
Json getArray(Json json, size_t index, Json defaultValue = null) {
  return json.isArray(index) ? json.getValue(index) : defaultValue;
}

Json getArray(Json json, string[] path, Json defaultValue = null) {
  return json.isArray(path) ? json.getValue(path) : defaultValue;
}

Json getArray(Json json, string key, Json defaultValue = null) {
  return json.isArray(key) ? json.getValue(key) : defaultValue;
}
// #endregion Json

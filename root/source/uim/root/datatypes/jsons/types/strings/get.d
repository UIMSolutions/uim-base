module uim.root.datatypes.jsons.types.strings.get;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

// #region Json[]
Json getString(Json[] jsons, size_t index, Json defaultValue = null) {
  return jsons.getValue(index).isString() ? jsons[index] : defaultValue;
}
// #endregion Json[]

// #region Json[string]
Json getString(Json[string] map, string[] path, Json defaultValue = null) {
  return map.getValue(path).isString ? map.getValue(path) : defaultValue;
}

Json getString(Json[string] map, string key, Json defaultValue = null) {
  return map.getValue(key).isString ? map.getValue(key) : defaultValue;
}
// #endregion Json[string]

// #region Json
Json getString(Json json, size_t index, Json defaultValue = null) {
  return json.isString(index) ? json.getValue(index) : defaultValue;
}

Json getString(Json json, string[] path, Json defaultValue = null) {
  return json.isString(path) ? json.getValue(path) : defaultValue;
}

Json getString(Json json, string key, Json defaultValue = null) {
  return json.isString(key) ? json.getValue(key) : defaultValue;
}
// #endregion Json

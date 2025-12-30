module uim.root.datatypes.jsons.types.doubles.get;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

// #region Json[]
Json getDouble(Json[] jsons, size_t index, Json defaultValue = null) {
  return jsons.getValue(index).isDouble() ? jsons[index] : defaultValue;
}
// #endregion Json[]

// #region Json[string]
Json getDouble(Json[string] map, string[] path, Json defaultValue = null) {
  return map.getValue(path).isDouble ? map.getValue(path) : defaultValue;
}

Json getDouble(Json[string] map, string key, Json defaultValue = null) {
  return map.getValue(key).isDouble ? map.getValue(key) : defaultValue;
}
// #endregion Json[string]

// #region Json
Json getDouble(Json json, size_t index, Json defaultValue = null) {
  return json.isDouble(index) ? json.getValue(index) : defaultValue;
}

Json getDouble(Json json, string[] path, Json defaultValue = null) {
  return json.isDouble(path) ? json.getValue(path) : defaultValue;
}

Json getDouble(Json json, string key, Json defaultValue = null) {
  return json.isDouble(key) ? json.getValue(key) : defaultValue;
}
// #endregion Json

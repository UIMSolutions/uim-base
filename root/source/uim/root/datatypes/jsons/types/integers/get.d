module uim.root.datatypes.jsons.types.integers.get;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

// #region Json[]
Json getInteger(Json[] jsons, size_t index, Json defaultValue = null) {
  return jsons.getValue(index).isInteger() ? jsons[index] : defaultValue;
}
// #endregion Json[]

// #region Json[string]
Json getInteger(Json[string] map, string[] path, Json defaultValue = null) {
  return map.getValue(path).isInteger ? map.getValue(path) : defaultValue;
}

Json getInteger(Json[string] map, string key, Json defaultValue = null) {
  return map.getValue(key).isInteger ? map.getValue(key) : defaultValue;
}
// #endregion Json[string]

// #region Json
Json getInteger(Json json, size_t index, Json defaultValue = null) {
  return json.isInteger(index) ? json.getValue(index) : defaultValue;
}

Json getInteger(Json json, string[] path, Json defaultValue = null) {
  return json.isInteger(path) ? json.getValue(path) : defaultValue;
}

Json getInteger(Json json, string key, Json defaultValue = null) {
  return json.isInteger(key) ? json.getValue(key) : defaultValue;
}
// #endregion Json

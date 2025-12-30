module uim.root.datatypes.jsons.types.scalars.get;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

// #region Json[]
Json getScalar(Json[] jsons, size_t index, Json defaultValue = null) {
  return jsons.getValue(index).isScalar() ? jsons[index] : defaultValue;
}
// #endregion Json[]

// #region Json[string]
Json getScalar(Json[string] map, string[] path, Json defaultValue = null) {
  return map.getValue(path).isScalar ? map.getValue(path) : defaultValue;
}

Json getScalar(Json[string] map, string key, Json defaultValue = null) {
  return map.getValue(key).isScalar ? map.getValue(key) : defaultValue;
}
// #endregion Json[string]

// #region Json
Json getScalar(Json json, size_t index, Json defaultValue = null) {
  return json.isScalar(index) ? json.getValue(index) : defaultValue;
}

Json getScalar(Json json, string[] path, Json defaultValue = null) {
  return json.isScalar(path) ? json.getValue(path) : defaultValue;
}

Json getScalar(Json json, string key, Json defaultValue = null) {
  return json.isScalar(key) ? json.getValue(key) : defaultValue;
}
// #endregion Json

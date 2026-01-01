module uim.root.datatypes.jsons.types.booleans.get;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

// #region Json[]
Json getBoolean(Json[] jsons, size_t index, Json defaultValue = null) {
  return jsons.getValue(index).isBoolean() ? jsons[index] : defaultValue;
}
// #endregion Json[]

// #region Json[string]
Json getBoolean(Json[string] map, string[] path, Json defaultValue = null) {
  return map.getValue(path).isBoolean ? map.getValue(path) : defaultValue;
}

Json getBoolean(Json[string] map, string key, Json defaultValue = null) {
  return map.getValue(key).isBoolean ? map.getValue(key) : defaultValue;
}
// #endregion Json[string]

// #region Json
Json getBoolean(Json json, size_t index, Json defaultValue = null) {
  return json.isBoolean(index) ? json.getValue(index) : defaultValue;
}

Json getBoolean(Json json, string[] path, Json defaultValue = null) {
  return json.isBoolean(path) ? json.getValue(path) : defaultValue;
}

Json getBoolean(Json json, string key, Json defaultValue = null) {
  return json.isBoolean(key) ? json.getValue(key) : defaultValue;
}
// #endregion Json

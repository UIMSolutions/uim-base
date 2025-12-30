module uim.root.datatypes.jsons.types.objects.get;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

// #region Json[]
Json getObject(Json[] jsons, size_t index, Json defaultValue = null) {
  return jsons.getValue(index).isObject() ? jsons[index] : defaultValue;
}
// #endregion Json[]

// #region Json[string]
Json getObject(Json[string] map, string[] path, Json defaultValue = null) {
  return map.getValue(path).isObject ? map.getValue(path) : defaultValue;
}

Json getObject(Json[string] map, string key, Json defaultValue = null) {
  return map.getValue(key).isObject ? map.getValue(key) : defaultValue;
}
// #endregion Json[string]

// #region Json
Json getObject(Json json, size_t index, Json defaultValue = null) {
  return json.isObject(index) ? json.getValue(index) : defaultValue;
}

Json getObject(Json json, string[] path, Json defaultValue = null) {
  return json.isObject(path) ? json.getValue(path) : defaultValue;
}

Json getObject(Json json, string key, Json defaultValue = null) {
  return json.isObject(key) ? json.getValue(key) : defaultValue;
}
// #endregion Json

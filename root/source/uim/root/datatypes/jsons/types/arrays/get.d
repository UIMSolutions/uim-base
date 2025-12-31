module uim.root.datatypes.jsons.types.arrays.get;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

// #region Json[]
Json[] getArrays(Json[] jsons, size_t[] indices) {
  return indices.filter!(index => jsons.length > index)
    .map!(index => jsons.getArray(index)).array;
}

Json getArray(Json[] jsons, size_t index, Json defaultValue = null) {
  return jsons.getValue(index).isArray() ? jsons[index] : defaultValue;
}
/// 
unittest {
  Json[] jsons = [[1, 2].toJson, ["a": 1].toJson, [3, 4].toJson];
  assert(jsons.getArray(0) == [1, 2].toJson);
  assert(jsons.getArray(1, Json("default")) == Json("default"));
  assert(jsons.getArray(2) == [3, 4].toJson);
}
// #endregion Json[]

// #region Json[string]
Json getArray(Json[string] map, string[] path, Json defaultValue = null) {
  return map.getValue(path).isArray ? map.getValue(path) : defaultValue;
}
/// 
unittest {
  Json[string] map = ["first": [1, 2].toJson, "second": ["a": 1].toJson, "third": [3, 4].toJson];
  assert(map.getArray("first") == [1, 2].toJson);
  assert(map.getArray("second", Json("default")) == Json("default"));
  assert(map.getArray("third") == [3, 4].toJson);
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

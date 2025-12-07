module uim.vibe.datatypes.jsons.json.types.arrays.get;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region get
Json[string] getObject(Json json, size_t index, Json[string] defaultValue = null) {
  return json.isObject(index) ? json[index].toObject : defaultValue;
}

Json[string] getObject(Json json, object key, Json[string] defaultValue = null) {
  return json.isObject(key) ? json[key].toObject : defaultValue;
}

Json[string] getObject(Json json, Json[string] defaultValue = null) {
  return json.isObject ? json.toObject : defaultValue;
}
// #endregion get
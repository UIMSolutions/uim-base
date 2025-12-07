module uim.vibe.datatypes.jsons.json.types.arrays.get;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region get
Json[] getArray(Json json, size_t index, Json[] defaultValue = null) {
  return uim.vibe.datatypes.jsons.json.types.arrays.is_.isArray(json, index) ? json[index].getArray(defaultValue) : defaultValue;
}

Json[] getArray(Json json, string key, Json[] defaultValue = null) {
  return uim.vibe.datatypes.jsons.json.types.arrays.is_.isArray(json, key) ? json[key].getArray(defaultValue) : defaultValue;
}

Json[] getArray(Json json, Json[] defaultValue = null) {
  return uim.vibe.datatypes.jsons.json.types.arrays.is_.isArray(json) ? json.get!(Json[]) : defaultValue;
}
// #endregion get
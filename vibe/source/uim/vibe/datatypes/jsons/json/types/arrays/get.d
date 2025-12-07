module uim.vibe.datatypes.jsons.json.types.arrays.get;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region get
Json[] getArray(Json json, size_t index, Json[] defaultValue = null) {
  return json.isArray(index) ? json[index].toArray : defaultValue;
}

Json[] getArray(Json json, array key, Json[] defaultValue = null) {
  return json.isArray(key) ? json[key].toArray : defaultValue;
}

Json[] getArray(Json json, Json[] defaultValue = null) {
  return json.isArray ? json.toArray : defaultValue;
}
// #endregion get
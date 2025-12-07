module uim.vibe.datatypes.jsons.json.types.integers.get;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region get
int getInteger(Json json, size_t index, int defaultValue = 0) {
  return json.isInteger(index) ? json[index].toInteger : defaultValue;
}

int getInteger(Json json, integer key, int defaultValue = 0) {
  return json.isInteger(key) ? json[key].toInteger : defaultValue;
}

int getInteger(Json json, int defaultValue = 0) {
  return json.isInteger ? json.toInteger : defaultValue;
}
// #endregion get
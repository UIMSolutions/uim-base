module uim.vibe.datatypes.jsons.json.types.doubles.get;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region get
double getDouble(Json json, size_t index, double defaultValue = 0.0) {
  return json.isDouble(index) ? json[index].toDouble : defaultValue;
}

double getDouble(Json json, double key, double defaultValue = 0.0) {
  return json.isDouble(key) ? json[key].toDouble : defaultValue;
}

double getDouble(Json json, double defaultValue = 0.0) {
  return json.isDouble ? json.toDouble : defaultValue;
}
// #endregion get
module uim.vibe.datatypes.jsons.arrays.types.doubles.get;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region get
double getDouble(Json[] jsons, size_t index, double defaultValue = 0.0) {
  import uim.vibe.datatypes.jsons.json.get;
  return jsons.length > index && jsons[index].isDouble ? getDouble(jsons[index], defaultValue) : defaultValue;
}
// #endregion get
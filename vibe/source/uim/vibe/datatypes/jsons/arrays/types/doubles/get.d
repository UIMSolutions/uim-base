module uim.vibe.datatypes.jsons.arrays.types.doubles.get;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region get
double getDouble(Json[] jsons, size_t index, double defaultValue = 0.0) {
  return jsons.length > index && jsons[index].isDouble ? jsons[index].getDouble(defaultValue) : defaultValue;
}
// #endregion get
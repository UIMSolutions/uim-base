module uim.vibe.datatypes.jsons.arrays.types.integers.get;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region get
int getInteger(Json[] jsons, size_t index, int defaultValue = 0) {
  // TODO: defaultValue parameter added in v1.2.0
  return jsons.length > index && jsons[index].isInteger ? getInteger(jsons[index]) : defaultValue;
}
// #endregion get
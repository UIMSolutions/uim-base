module uim.vibe.datatypes.jsons.arrays.get;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region get
Json[] getArray(Json[] jsons, size_t index, Json[] defaultValue = null) {
  return jsons.length > index && jsons[index].isArray ? jsons[index].getArray(defaultValue) : defaultValue;
}
// #endregion get
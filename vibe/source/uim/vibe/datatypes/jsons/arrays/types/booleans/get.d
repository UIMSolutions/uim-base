module uim.vibe.datatypes.jsons.arrays.types.booleans.get;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region get
bool getBoolean(Json[] jsons, size_t index, bool defaultValue = false) {
  return jsons.length > index && jsons[index].isBoolean ? jsons[index].getBoolean(defaultValue) : defaultValue;
}
// #endregion get
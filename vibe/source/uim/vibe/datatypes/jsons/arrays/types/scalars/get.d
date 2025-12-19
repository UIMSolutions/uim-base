module uim.vibe.datatypes.jsons.arrays.types.strings.get;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region get
string getString(Json[] jsons, size_t index, string defaultValue = "") {
  return jsons.length > index && jsons[index].isString ? jsons[index].getString(defaultValue) : defaultValue;
}
// #endregion get
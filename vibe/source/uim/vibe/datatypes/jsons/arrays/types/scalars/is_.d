module uim.vibe.datatypes.jsons.arrays.types.scalars.is_;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region all
// #region noIndex
bool isAllString(Json[] values) {
  return values.all!(value => uim.vibe.datatypes.jsons.json.types.strings.isString(value));
}
// #endregion noIndex

// #region index  
bool isAllString(Json[] values, size_t[] indices) {
  return indices.all!(index => values.isString(index));
}
// #endregion index
// #endregion all

// #region any
// #region noIndex
bool isAnyString(Json[] values) {
  return values.any!(value => uim.vibe.datatypes.jsons.json.types.strings.isString(value));
}
// #endregion noIndex

// #region index
bool isAnyString(Json[] values, size_t[] indices) {
  return indices.any!(index => values.isString(index));
}
// #endregion index
// #endregion any

// #region is
bool isString(Json[] values, size_t index) {
  if (index >= values.length) {
    return false;
  } 

  return uim.vibe.datatypes.jsons.json.types.strings.isString(values[index]);
}
// #endregion is
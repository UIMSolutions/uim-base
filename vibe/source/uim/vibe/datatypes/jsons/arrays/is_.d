module uim.vibe.datatypes.jsons.arrays.is_;

import uim.vibe;
import uim.vibe.datatypes.jsons.json.types.arrays;

mixin(Version!("test_uim_vibe"));

@safe:

// #region all
// #region noIndex
bool isAllArray(Json[] values) {
  return values.all!(value => uim.vibe.datatypes.jsons.json.types.arrays.isArray(value));
}
// #endregion noIndex

// #region index  
bool isAllArray(Json[] values, size_t[] indices) {
  return indices.all!(index => values.isArray(index));
}
// #endregion index
// #endregion all

// #region any
// #region noIndex
bool isAnyArray(Json[] values) {
  return values.any!(value => uim.vibe.datatypes.jsons.json.types.arrays.isArray(value));
}
// #endregion noIndex

// #region index
bool isAnyArray(Json[] values, size_t[] indices) {
  return indices.any!(index => values.isArray(index));
}
// #endregion index
// #endregion any

// #region is
bool isArray(Json[] values, size_t index) {
  if (index >= values.length) {
    return false;
  } 

  return uim.vibe.datatypes.jsons.json.types.arrays.isArray(values[index]);
}
// #endregion is
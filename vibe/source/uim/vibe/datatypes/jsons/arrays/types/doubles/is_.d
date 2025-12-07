module uim.vibe.datatypes.jsons.arrays.types.doubles.is_;

import uim.vibe;
import uim.vibe.datatypes.jsons.json.types.doubles;

mixin(Version!("test_uim_vibe"));

@safe:

// #region all
// #region noIndex
bool isAllDouble(Json[] values) {
  return values.all!(value => uim.vibe.datatypes.jsons.json.types.doubles.isDouble(value));
}
// #endregion noIndex

// #region index  
bool isAllDouble(Json[] values, size_t[] indices) {
  return indices.all!(index => values.isDouble(index));
}
// #endregion index
// #endregion all

// #region any
// #region noIndex
bool isAnyDouble(Json[] values) {
  return values.any!(value => uim.vibe.datatypes.jsons.json.types.doubles.isDouble(value));
}
// #endregion noIndex

// #region index
bool isAnyDouble(Json[] values, size_t[] indices) {
  return indices.any!(index => values.isDouble(index));
}
// #endregion index
// #endregion any

// #region is
bool isDouble(Json[] values, size_t index) {
  if (index >= values.length) {
    return false;
  } 

  return uim.vibe.datatypes.jsons.json.types.doubles.isDouble(values[index]);
}
// #endregion is
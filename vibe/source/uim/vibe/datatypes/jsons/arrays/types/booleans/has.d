module uim.vibe.datatypes.jsons.arrays.types.booleans.has;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region all
// #region noIndex
bool hasAllBoolean(Json[] values) {
  return values.all!(value => value.isBoolean);
}
// #endregion noIndex

// #region index  
bool hasAllBoolean(Json[] values, size_t[] indices) {
  return indices.all!(index => values.isBoolean(index));
}
// #endregion index
// #endregion all

// #region any
// #region noIndex
bool hasAnyBoolean(Json[] values) {
  return values.any!(value => value.isBoolean);
}
// #endregion noIndex

// #region index
bool hasAnyBoolean(Json[] values, size_t[] indices) {
  return indices.any!(index => values.isBoolean(index));
}
// #endregion index
// #endregion any

// #region is
bool hasBoolean(Json[] values, size_t index) {
  if (index >= values.length) {
    return false;
  } 

  return values[index].isBoolean;
}
// #endregion is
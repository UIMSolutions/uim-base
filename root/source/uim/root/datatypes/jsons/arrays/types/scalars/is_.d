module uim.root.datatypes.jsons.arrays.types.scalars.is_;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

// #region all
// #region noIndex
bool isAllScalar(Json[] values) {
  return values.all!(value => isScalar(value));
}
// #endregion noIndex

// #region index  
bool isAllScalar(Json[] values, size_t[] indices) {
  return indices.all!(index => values.isScalar(index));
}
// #endregion index
// #endregion all

// #region any
// #region noIndex
bool isAnyScalar(Json[] values) {
  return values.any!(value => isScalar(value));
}
// #endregion noIndex

// #region index
bool isAnyScalar(Json[] values, size_t[] indices) {
  return indices.any!(index => values.isScalar(index));
}
// #endregion index
// #endregion any

// #region is
bool isScalar(Json[] values, size_t index) {
  if (index >= values.length) {
    return false;
  } 

  return uim.root.datatypes.jsons.typecheck.isScalar(values[index]);
}
// #endregion is
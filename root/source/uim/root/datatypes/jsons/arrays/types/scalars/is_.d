module uim.root.datatypes.jsons.arrays.types.scalars.is_;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

// #region all
// #region noIndex
bool isAllScalar(Json[] jsons) {
  return jsons.all!(json => isScalar(json));
}
// #endregion noIndex

// #region index  
bool isAllScalar(Json[] jsons, size_t[] indices) {
  return indices.all!(index => jsons.isScalar(index));
}
// #endregion index
// #endregion all

// #region any
// #region noIndex
bool isAnyScalar(Json[] jsons) {
  return jsons.any!(json => isScalar(json));
}
// #endregion noIndex

// #region index
bool isAnyScalar(Json[] jsons, size_t[] indices) {
  return indices.any!(index => jsons.isScalar(index));
}
// #endregion index
// #endregion any

// #region is
bool isScalar(Json[] values, size_t index) {
  return values.length > index ? values[index].isScalar : false;
}
// #endregion is
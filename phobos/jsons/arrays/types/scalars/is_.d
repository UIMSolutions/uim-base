module uim.root.datatypes.jsons.arrays.types.scalars.is_;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

// #region all
// #region noIndex
bool isAllScalar(Json[] jsons) {
  import uim.root.datatypes.jsons.json.types.scalars.is_;
  return jsons.all!(json => uim.root.datatypes.jsons.json.types.scalars.is_.isScalar(json));
}
// #endregion noIndex

// #region index  
bool isAllScalar(Json[] jsons, size_t[] indices) {
  import uim.root.datatypes.jsons.json.types.scalars.is_;
  return indices.all!(index => jsons.length > index && uim.root.datatypes.jsons.json.types.scalars.is_.isScalar(jsons[index]));
}
// #endregion index
// #endregion all

// #region any
// #region noIndex
bool isAnyScalar(Json[] jsons) {
  import uim.root.datatypes.jsons.json.types.scalars.is_;
  return jsons.any!(json => uim.root.datatypes.jsons.json.types.scalars.is_.isScalar(json));
}
// #endregion noIndex

// #region index
bool isAnyScalar(Json[] jsons, size_t[] indices) {
  import uim.root.datatypes.jsons.json.types.scalars.is_;
  return indices.any!(index => jsons.length > index && uim.root.datatypes.jsons.json.types.scalars.is_.isScalar(jsons[index]));
}
// #endregion index
// #endregion any

// #region is
bool isScalar(Json[] values, size_t index) {
  import uim.root.datatypes.jsons.json.types.scalars.is_;
  return values.length > index ? uim.root.datatypes.jsons.json.types.scalars.is_.isScalar(values[index]) : false;
}
// #endregion is
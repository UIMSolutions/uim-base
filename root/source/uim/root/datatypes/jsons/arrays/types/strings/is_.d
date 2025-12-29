module uim.root.datatypes.jsons.arrays.types.strings.is_;

import uim.root;
import uim.root.datatypes.jsons.json.types.strings;

mixin(Version!("test_uim_root"));

@safe:

// #region all
// #region noIndex
bool isAllString(Json[] values) {
  return values.all!(value => uim.root.datatypes.jsons.typecheck.isString(value));
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
  return values.any!(value => uim.root.datatypes.jsons.typecheck.isString(value));
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

  return uim.root.datatypes.jsons.typecheck.isString(values[index]);
}
// #endregion is
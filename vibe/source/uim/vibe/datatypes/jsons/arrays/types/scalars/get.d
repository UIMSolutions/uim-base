module uim.vibe.datatypes.jsons.arrays.types.scalars.get;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region get
scalar getScalar(Json[] jsons, size_t index, scalar defaultValue = "") {
  return jsons.length > index && jsons[index].isScalar ? jsons[index].getScalar(defaultValue) : defaultValue;
}
// #endregion get
module uim.vibe.datatypes.jsons.arrays.types.scalars.get;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region get
Json getScalar(Json[] jsons, size_t index, Json defaultValue = Json(null)) {
  return jsons.length > index && jsons[index].isScalar ? jsons[index].getScalar(defaultValue) : defaultValue;
}
// #endregion get
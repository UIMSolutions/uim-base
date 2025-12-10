module uim.vibe.datatypes.jsons.arrays.types.objects.get;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region get
Json[string] getObject(Json[] jsons, size_t index, Json[string] defaultValue = null) {
  return jsons.length > index && jsons[index].isObject ? jsons[index].getObject(defaultValue) : defaultValue;
}
// #endregion get
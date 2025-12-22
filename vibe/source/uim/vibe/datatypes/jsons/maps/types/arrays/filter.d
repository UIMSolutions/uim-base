module uim.vibe.datatypes.jsons.maps.types.arrays.filterx;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

Json[] filterArrays(Json[string] items, bool delegate(Json json) @safe filterFunc) {
  return items.filterArrays.filter!(json => filterFunc(json)).array;
}

Json[] filterArrays(Json[string] items, string[] keys) {
  return items.filterKeys(keys).filter!(json => json.isObject).array;
}

Json[] filterArrays(Json[string] items) {
  return items.byValue.array.filter!(json => json.isArray).array;
}

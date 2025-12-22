module uim.vibe.datatypes.jsons.maps.types.booleans.filter;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

Json[] filterBooleans(Json[string] items, bool delegate(Json json) @safe filterFunc) {
  return items.filterArrays.filter!(json => filterFunc(json)).array;
}

Json[] filterBooleans(Json[string] items, string[] keys) {
  return items.filterKeys(keys).filter!(json => json.isBoolean).array;
}

Json[] filterBooleans(Json[string] items) {
  return items.byValue.array.filter!(json => json.isBoolean).array;
}

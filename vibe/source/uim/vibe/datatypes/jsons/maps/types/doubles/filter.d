module uim.vibe.datatypes.jsons.maps.types.doubles.filter;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

Json[] filterDoubles(Json[string] items, bool delegate(Json json) @safe filterFunc) {
  return items.filterDoubles.filter!(json => filterFunc(json)).array;
}

Json[] filterDoubles(Json[string] items, string[] keys) {
  return items.filterKeys(keys).filter!(json => json.isDouble).array;
}

Json[] filterDoubles(Json[string] items) {
  return items.byValue.array.filter!(json => json.isDouble).array;
}

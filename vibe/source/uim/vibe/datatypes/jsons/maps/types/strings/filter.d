module uim.vibe.datatypes.jsons.maps.types.strings.filter;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

Json[] filterStrings(Json[string] items, bool delegate(Json json) @safe filterFunc) {
  return items.filterStrings.filter!(json => filterFunc(json)).array;
}

Json[] filterStrings(Json[string] items, string[] keys) {
  return items.filterKeys(keys).filter!(json => json.isString).array;
}

Json[] filterStrings(Json[string] items) {
  return items.byValue.array.filter!(json => json.isString).array;
}

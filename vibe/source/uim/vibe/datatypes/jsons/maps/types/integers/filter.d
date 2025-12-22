module uim.vibe.datatypes.jsons.maps.types.integers.filter;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

Json[string] filterIntegers(Json[string] items, bool delegate(Json json) @safe filterFunc) {
  return items.filterIntegers.filter!(json => filterFunc(json)).array;
}

Json[string] filterIntegers(Json[string] items, string[] keys) {
  return items.filterKeys(keys).filter!(json => json.isInteger).array;
}

Json[string] filterIntegers(Json[string] items) {
  return items.byValue.array.filter!(json => json.isInteger).array;
}

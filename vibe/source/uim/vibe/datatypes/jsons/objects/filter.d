module uim.vibe.datatypes.jsons.objects.filter;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region keys
Json[] filterKeys(Json[string] items, string[] keys) {
  return keys.filter!(key => key in items).map!(key => items[key]).array;
}
// #region keys

// #region Objects
Json[] filterObjects(Json[string] items, bool delegate(Json json) @safe filterFunc) {
  return items.filterObjects.filter!(json => filterFunc(json)).array;
}

Json[] filterObjects(Json[string] items, string[] keys) {
  return items.filterKeys(keys).filter!(json => json.isObject).array;
}

Json[] filterObjects(Json[string] items) {
  return items.byValue.array.filter!(json => json.isObject).array;
}
// #endregion Objects

Json[] filterArrays(Json[string] items) {
  return items.byValue.array.filter!(json => json.isArray).array;
}

Json[] filterArrays(Json[string] items) {
  return items.byValue.array.filter!(json => json.isArray).array;
}

Json[] filterBooleans(Json[string] items) {
  return items.byValue.array.filter!(json => json.isBoolean).array;
}

Json[] filterBooleans(Json[string] items) {
  return items.byValue.array.filter!(json => json.isBoolean).array;
}

Json[] filterIntegers(Json[string] items) {
  return items.byValue.array.filter!(json => json.isInteger).array;
}

Json[] filterDoubles(Json[string] items) {
  return items.byValue.array.filter!(json => json.isDouble).array;
}

Json[] filterStrings(Json[string] items) {
  return items.byValue.array.filter!(json => json.isString).array;
}

/* 
Json[] filterValues(Json[string] items) {
  return items.byValue.array.filter!(json => json.isValue).array;
}
*/ 

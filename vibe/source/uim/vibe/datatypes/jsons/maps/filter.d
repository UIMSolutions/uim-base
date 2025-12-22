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

// #region Arrays
// #endregion Arrays

// #region Scalars
Json[] filterScalars(Json[string] items, bool delegate(Json json) @safe filterFunc) {
  return items.filterScalars.filter!(json => filterFunc(json)).array;
}

Json[] filterScalars(Json[string] items, string[] keys) {
  return items.filterKeys(keys).filter!(json => json.isScalar).array;
}

Json[] filterScalars(Json[string] items) {
  return items.byValue.array.filter!(json => json.isScalar).array;
}
// #endregion Scalars


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
Json[] filterArrays(Json[string] items, bool delegate(Json json) @safe filterFunc) {
  return items.filterArrays.filter!(json => filterFunc(json)).array;
}

Json[] filterArrays(Json[string] items, string[] keys) {
  return items.filterKeys(keys).filter!(json => json.isObject).array;
}

Json[] filterArrays(Json[string] items) {
  return items.byValue.array.filter!(json => json.isArray).array;
}
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

// #region Booleans
Json[] filterBooleans(Json[string] items, bool delegate(Json json) @safe filterFunc) {
  return items.filterArrays.filter!(json => filterFunc(json)).array;
}

Json[] filterBooleans(Json[string] items, string[] keys) {
  return items.filterKeys(keys).filter!(json => json.isBoolean).array;
}

Json[] filterBooleans(Json[string] items) {
  return items.byValue.array.filter!(json => json.isBoolean).array;
}
// #endregion Booleans

// #region Integers
// #endregion Integers

// #region Doubles
Json[] filterDoubles(Json[string] items, bool delegate(Json json) @safe filterFunc) {
  return items.filterDoubles.filter!(json => filterFunc(json)).array;
}

Json[] filterDoubles(Json[string] items, string[] keys) {
  return items.filterKeys(keys).filter!(json => json.isDouble).array;
}

Json[] filterDoubles(Json[string] items) {
  return items.byValue.array.filter!(json => json.isDouble).array;
}
// #endregion Doubles

// #region Strings
Json[] filterStrings(Json[string] items, bool delegate(Json json) @safe filterFunc) {
  return items.filterStrings.filter!(json => filterFunc(json)).array;
}

Json[] filterStrings(Json[string] items, string[] keys) {
  return items.filterKeys(keys).filter!(json => json.isString).array;
}

Json[] filterStrings(Json[string] items) {
  return items.byValue.array.filter!(json => json.isString).array;
}
// #endregion Strings

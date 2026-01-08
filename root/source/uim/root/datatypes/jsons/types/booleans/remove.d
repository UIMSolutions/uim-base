/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.types.booleans.remove;

import uim.root;

mixin(ShowModule!());

@safe:
 
// #region Json[]
// #region indices
Json[] removeBooleans(Json[] jsons, size_t[] indices, bool delegate(size_t) @safe removeFunc) {
  return jsons.removeIndices(indices, removeFunc).removeBooleans;
}

Json[] removeBooleans(Json[] jsons, bool delegate(size_t) @safe removeFunc) {
  return jsons.removeIndices(removeFunc).removeBooleans;
}

Json[] removeBooleans(Json[] jsons, size_t[] indices) {
  return jsons.removeIndices(indices).removeBooleans;
}
// #endregion indices

// #region values
Json[] removeBooleans(Json[] jsons, Json[] values, bool delegate(Json) @safe removeFunc) {
  return jsons.removeValues(values, removeFunc).removeBooleans;
}

Json[] removeBooleans(Json[] jsons, bool delegate(Json) @safe removeFunc) {
  return jsons.removeValues(removeFunc).removeBooleans;
}

Json[] removeBooleans(Json[] jsons, Json[] values) {
  return jsons.removeValues(values).removeBooleans;
}
// #endregion values

// #region base
Json[] removeBooleans(Json[] jsons) {
  return jsons.removeValues((Json json) => json.isBoolean).removeBooleans;
}
// #endregion base
// #endregion Json[]

// #region Json[string]
// #region keys
Json[string] removeBooleans(Json[string] map, string[] keys, bool delegate(string) @safe removeFunc) {
  return map.removeKeys(keys, removeFunc).removeBooleans;
}

Json[string] removeBooleans(Json[string] map, string[] keys) {
  return map.removeKeys(keys).removeBooleans;
}

Json[string] removeBooleans(Json[string] map, bool delegate(string) @safe removeFunc) {
  return map.removeKeys(removeFunc).removeBooleans;
}
// #endregion keys

// #region values
Json[string] removeBooleans(Json[string] map, Json[] values, bool delegate(Json) @safe removeFunc) {
  return map.removeValues(values, removeFunc).removeBooleans;
}

Json[string] removeBooleans(Json[string] map, Json[] values) {
  return map.removeValues(values).removeBooleans;
}

Json[string]   removeBooleans(Json[string] map, bool delegate(Json) @safe removeFunc) {
  return map.removeValues(removeFunc).removeBooleans;
}
// #endregion values

// #region base
Json[string] removeBooleans(Json[string] map) {
  return map.removeValues((Json json) => json.isBoolean);
}
// #endregion base
// #endregion Json[string]

// #region Json
// #region indices
Json removeBooleans(Json json, size_t[] indices, bool delegate(size_t) @safe removeFunc) {
  return json.removeIndices(indices, removeFunc).removeBooleans;
}

Json removeBooleans(Json json, bool delegate(size_t) @safe removeFunc) {
  return json.removeIndices(removeFunc).removeBooleans;
}

Json removeBooleans(Json json, size_t[] indices) {
  return json.removeIndices(indices).removeBooleans;
}
// #endregion indices

// #region keys
Json removeBooleans(Json json, string[] keys, bool delegate(string) @safe removeFunc) {
  return json.removeKeys(keys, removeFunc).removeBooleans;
}

Json removeBooleans(Json json, string[] keys) {
  return json.removeKeys(keys).removeBooleans;
}

Json removeBooleans(Json json, bool delegate(string) @safe removeFunc) {
  return json.removeKeys(removeFunc).removeBooleans;
}
// #endregion keys

// #region values
Json removeBooleans(Json json, Json[] values, bool delegate(Json) @safe removeFunc) {
  return json.removeValues(values, removeFunc).removeBooleans;
}

Json removeBooleans(Json json, Json[] values) {
  return json.removeValues(values).removeBooleans;
}

Json removeBooleans(Json json, bool delegate(Json) @safe removeFunc) {
  return json.removeValues(removeFunc).removeBooleans;
}
// #endregion values

// #region base
Json removeBooleans(Json json) {
  return json.removeValues((Json j) => j.isBoolean);
}
// #endregion base
// #endregion Json



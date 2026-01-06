/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.types.booleans.remove;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:
 
// #region Json[]
// #region indices
Json[] removeArrays(Json[] jsons, size_t[] indices, bool delegate(size_t) @safe removeFunc) {
  return jsons.removeIndices(indices, removeFunc).removeArrays;
}

Json[] removeArrays(Json[] jsons, bool delegate(size_t) @safe removeFunc) {
  return jsons.removeIndices(removeFunc).removeArrays;
}

Json[] removeArrays(Json[] jsons, size_t[] indices) {
  return jsons.removeIndices(indices).removeArrays;
}
// #endregion indices

// #region values
Json[] removeArrays(Json[] jsons, Json[] values, bool delegate(Json) @safe removeFunc) {
  return jsons.removeValues(values, removeFunc).removeArrays;
}

Json[] removeArrays(Json[] jsons, bool delegate(Json) @safe removeFunc) {
  return jsons.removeValues(removeFunc).removeArrays;
}

Json[] removeArrays(Json[] jsons, Json[] values) {
  return jsons.removeValues(values).removeArrays;
}
// #endregion values

// #region base
Json[] removeArrays(Json[] jsons) {
  return jsons.removeValues((Json json) => json.isArray).removeArrays;
}
// #endregion base
// #endregion Json[]

// #region Json[string]
// #region keys
Json[string] removeArrays(Json[string] map, string[] keys, bool delegate(string) @safe removeFunc) {
  return map.removeKeys(keys, removeFunc).removeArrays;
}

Json[string] removeArrays(Json[string] map, string[] keys) {
  return map.removeKeys(keys).removeArrays;
}

Json[string] removeArrays(Json[string] map, bool delegate(string) @safe removeFunc) {
  return map.removeKeys(removeFunc).removeArrays;
}
// #endregion keys

// #region values
Json[string] removeArrays(Json[string] map, Json[] values, bool delegate(Json) @safe removeFunc) {
  return map.removeValues(values, removeFunc).removeArrays;
}

Json[string] removeArrays(Json[string] map, Json[] values) {
  return map.removeValues(values).removeArrays;
}

Json[string]   removeArrays(Json[string] map, bool delegate(Json) @safe removeFunc) {
  return map.removeValues(removeFunc).removeArrays;
}
// #endregion values

// #region base
Json[string] removeArrays(Json[string] map) {
  return map.removeValues((Json json) => json.isArray);
}
// #endregion base
// #endregion Json[string]

// #region Json
// #region indices
Json removeArrays(Json json, size_t[] indices, bool delegate(size_t) @safe removeFunc) {
  return json.removeIndices(indices, removeFunc).removeArrays;
}

Json removeArrays(Json json, bool delegate(size_t) @safe removeFunc) {
  return json.removeIndices(removeFunc).removeArrays;
}

Json removeArrays(Json json, size_t[] indices) {
  return json.removeIndices(indices).removeArrays;
}
// #endregion indices

// #region keys
Json removeArrays(Json json, string[] keys, bool delegate(string) @safe removeFunc) {
  return json.removeKeys(keys, removeFunc).removeArrays;
}

Json removeArrays(Json json, string[] keys) {
  return json.removeKeys(keys).removeArrays;
}

Json removeArrays(Json json, bool delegate(string) @safe removeFunc) {
  return json.removeKeys(removeFunc).removeArrays;
}
// #endregion keys

// #region values
Json removeArrays(Json json, Json[] values, bool delegate(Json) @safe removeFunc) {
  return json.removeValues(values, removeFunc).removeArrays;
}

Json removeArrays(Json json, Json[] values) {
  return json.removeValues(values).removeArrays;
}

Json removeArrays(Json json, bool delegate(Json) @safe removeFunc) {
  return json.removeValues(removeFunc).removeArrays;
}
// #endregion values

// #region base
Json removeArrays(Json json) {
  return json.removeValues((Json j) => j.isArray);
}
// #endregion base
// #endregion Json



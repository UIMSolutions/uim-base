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
  mixin(ShowFunction!());
  
  return jsons.removeIndices(indices, (size_t index) => jsons[index].isBoolean && removeFunc(index));
}

Json[] removeBooleans(Json[] jsons, size_t[] indices) {
  mixin(ShowFunction!());

  return jsons.removeIndices(indices, (index) => jsons[index].isBoolean);
}

Json[] removeBooleans(Json[] jsons, bool delegate(size_t) @safe removeFunc) {
  mixin(ShowFunction!());

  return jsons.removeIndices((size_t index) => jsons[index].isBoolean && removeFunc(index));
}
// #endregion indices

// #region values
Json[] removeBooleans(Json[] jsons, Json[] values, bool delegate(Json) @safe removeFunc) {
  mixin(ShowFunction!());

  return jsons.removeValues(values, (Json json) => json.isBoolean && removeFunc(json));
}

Json[] removeBooleans(Json[] jsons, Json[] values) {
  mixin(ShowFunction!());

  return jsons.removeValues(values, (Json json) => json.isBoolean);
}

Json[] removeBooleans(Json[] jsons, bool delegate(Json) @safe removeFunc) {
  mixin(ShowFunction!());

  return jsons.removeValues((Json json) => json.isBoolean && removeFunc(json));
}
// #endregion values

// #region base
Json[] removeBooleans(Json[] jsons) {
  mixin(ShowFunction!());

  return jsons.removeValues((Json json) => json.isBoolean);
}
// #endregion base
// #endregion Json[]

// #region Json[string]
// #region keys
Json[string] removeBooleans(Json[string] map, string[] keys, bool delegate(string) @safe removeFunc) {
  mixin(ShowFunction!());

  return map.removeKeys(keys, (string key) => map[key].isBoolean && removeFunc(key));
}

Json[string] removeBooleans(Json[string] map, string[] keys) {
  mixin(ShowFunction!());

  return map.removeKeys(keys, (string key) => map.getValue(key).isBoolean);
}

Json[string] removeBooleans(Json[string] map, bool delegate(string) @safe removeFunc) {
  mixin(ShowFunction!());

  return map.removeKeys((string key) => map[key].isBoolean && removeFunc(key));
}
// #endregion keys

// #region values
Json[string] removeBooleans(Json[string] map, Json[] values, bool delegate(Json) @safe removeFunc) {
  mixin(ShowFunction!());

  return map.removeValues(values, (Json json) => json.isBoolean && removeFunc(json));
}

Json[string] removeBooleans(Json[string] map, Json[] values) {
  mixin(ShowFunction!());

  return map.removeValues(values, (Json json) => json.isBoolean);
}

Json[string] removeBooleans(Json[string] map, bool delegate(Json) @safe removeFunc) {
  mixin(ShowFunction!());
  
  return map.removeValues((Json json) => json.isBoolean && removeFunc(json));
}
// #endregion values

// #region base
Json[string] removeBooleans(Json[string] map) {
  mixin(ShowFunction!());
  
  return map.removeValues((Json json) => json.isBoolean);
}
// #endregion base
// #endregion Json[string]

// #region Json
// #region indices
Json removeBooleans(Json json, size_t[] indices, bool delegate(size_t) @safe removeFunc) {
  mixin(ShowFunction!());
  
  return json.removeIndices(indices, (size_t index) => json.getValue(index)
      .isBoolean && removeFunc(index));
}

Json removeBooleans(Json json, size_t[] indices) {
  mixin(ShowFunction!());

  return json.removeIndices(indices, (size_t index) => json[index].isBoolean);
}

Json removeBooleans(Json json, bool delegate(size_t) @safe removeFunc) {
  mixin(ShowFunction!());
  
  return json.removeIndices((size_t index) => json.getValue(index).isBoolean && removeFunc(index));
}
// #endregion indices

// #region keys
Json removeBooleans(Json json, string[] keys, bool delegate(string) @safe removeFunc) {
  mixin(ShowFunction!());
  
  return json.removeKeys(keys, (string key) => json[key].isBoolean && removeFunc(key));
}

Json removeBooleans(Json json, string[] keys) {
  mixin(ShowFunction!());

  return json.removeKeys(keys, (string key) => json.getValue(key).isBoolean);
}

Json removeBooleans(Json json, bool delegate(string) @safe removeFunc) {
  mixin(ShowFunction!());
  
  return json.removeKeys((string key) => json.getValue(key).isBoolean && removeFunc(key));
}
// #endregion keys

// #region values
Json removeBooleans(Json json, Json[] values, bool delegate(Json) @safe removeFunc) {
  mixin(ShowFunction!());

  return json.removeValues(values, (Json j) => j.isBoolean && removeFunc(j));
}

Json removeBooleans(Json json, Json[] values) {
  mixin(ShowFunction!());

  return json.removeValues(values, (Json j) => j.isBoolean);
}

Json removeBooleans(Json json, bool delegate(Json) @safe removeFunc) {
  mixin(ShowFunction!());

  return json.removeValues((Json j) => j.isBoolean && removeFunc(j));
}
// #endregion values

// #region base
Json removeBooleans(Json json) {
  mixin(ShowFunction!());

  return json.removeValues((Json j) => j.isBoolean);
}
// #endregion base
// #endregion Json



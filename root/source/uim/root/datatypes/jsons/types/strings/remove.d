/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.types.strings.remove;

import uim.root;

mixin(ShowModule!());

@safe:
 
// #region Json[]
// #region indices
Json[] removeStrings(Json[] jsons, size_t[] indices, bool delegate(size_t) @safe removeFunc) {
  mixin(ShowFunction!());
  
  return jsons.removeIndices(indices, (size_t index) => jsons[index].isString && removeFunc(index));
}
///
unittest {
  mixin(ShowTest!("Json[] removeStrings(Json[] jsons, size_t[] indices, bool delegate(size_t) @safe removeFunc)"));

  Json[] jsons = [Json("string"), Json(123), Json("another string"), Json(true), Json.nullValue];
  size_t[] indices = [0, 2, 4];

  Json[] result = removeStrings(jsons, indices, (size_t index) => true);
  assert(result.length == 2);
  assert(result[0] == Json(123));
  assert(result[1] == Json(true));

  result = removeStrings(jsons, indices, (size_t index) => false);;
  assert(result.length == 5);

  result = removeStrings(jsons, indices, (size_t index) => index == 2);
  assert(result.length == 4);
  assert(result[0] == Json(123));
  assert(result[1] == Json(true));  
}
///
unittest {
  mixin(ShowTest!("Json[] removeStrings(Json[] jsons, size_t[] indices)"));

  Json[] jsons = [Json("string"), Json(123), Json("another string"), Json(true), Json.nullValue];
  size_t[] indices = [0, 2, 4];

  Json[] result = removeStrings(jsons, indices);
  assert(result.length == 2);
  assert(result[0] == Json(123));
  assert(result[1] == Json(true));  
}

Json[] removeStrings(Json[] jsons, size_t[] indices) {
  mixin(ShowFunction!());

  return jsons.removeIndices(indices, (index) => jsons[index].isString);
}
///
unittest {
  mixin(ShowTest!("Json[] removeStrings(Json[] jsons, bool delegate(size_t) @safe removeFunc)"));

  Json[] jsons = [Json("string"), Json(123), Json("another string"), Json(true), Json.nullValue];

  Json[] result = removeStrings(jsons, (size_t index) => true);
  assert(result.length == 2);
  assert(result[0] == Json(123));
  assert(result[1] == Json(true));

  result = removeStrings(jsons, (size_t index) => false);;
  assert(result.length == 5);

  result = removeStrings(jsons, (size_t index) => index == 2);
  assert(result.length == 4);
  assert(result[0] == Json("string"));
  assert(result[1] == Json(123));
  assert(result[2] == Json(true));  
}

Json[] removeStrings(Json[] jsons, bool delegate(size_t) @safe removeFunc) {
  mixin(ShowFunction!());

  return jsons.removeIndices((size_t index) => jsons[index].isString && removeFunc(index));
}
///
unittest {
  mixin(ShowTest!("Json[] removeStrings(Json[] jsons)"));

  Json[] jsons = [Json("string"), Json(123), Json("another string"), Json(true), Json.nullValue];

  Json[] result = removeStrings(jsons);
  assert(result.length == 2);
  assert(result[0] == Json(123));
  assert(result[1] == Json(true));  
}
// #endregion indices

// #region values
Json[] removeStrings(Json[] jsons, Json[] values, bool delegate(Json) @safe removeFunc) {
  mixin(ShowFunction!());

  return jsons.removeValues(values, (Json json) => json.isString && removeFunc(json));
}

Json[] removeStrings(Json[] jsons, Json[] values) {
  mixin(ShowFunction!());

  return jsons.removeValues(values, (Json json) => json.isString);
}

Json[] removeStrings(Json[] jsons, bool delegate(Json) @safe removeFunc) {
  mixin(ShowFunction!());

  return jsons.removeValues((Json json) => json.isString && removeFunc(json));
}
// #endregion values

// #region base
Json[] removeStrings(Json[] jsons) {
  mixin(ShowFunction!());

  return jsons.removeValues((Json json) => json.isString);
}
// #endregion base
// #endregion Json[]

// #region Json[string]
// #region keys
Json[string] removeStrings(Json[string] map, string[] keys, bool delegate(string) @safe removeFunc) {
  mixin(ShowFunction!());

  return map.removeKeys(keys, (string key) => map[key].isString && removeFunc(key));
}

Json[string] removeStrings(Json[string] map, string[] keys) {
  mixin(ShowFunction!());

  return map.removeKeys(keys, (string key) => map.getValue(key).isString);
}

Json[string] removeStrings(Json[string] map, bool delegate(string) @safe removeFunc) {
  mixin(ShowFunction!());

  return map.removeKeys((string key) => map[key].isString && removeFunc(key));
}
// #endregion keys

// #region values
Json[string] removeStrings(Json[string] map, Json[] values, bool delegate(Json) @safe removeFunc) {
  mixin(ShowFunction!());

  return map.removeValues(values, (Json json) => json.isString && removeFunc(json));
}

Json[string] removeStrings(Json[string] map, Json[] values) {
  mixin(ShowFunction!());

  return map.removeValues(values, (Json json) => json.isString);
}

Json[string] removeStrings(Json[string] map, bool delegate(Json) @safe removeFunc) {
  mixin(ShowFunction!());
  
  return map.removeValues((Json json) => json.isString && removeFunc(json));
}
// #endregion values

// #region base
Json[string] removeStrings(Json[string] map) {
  mixin(ShowFunction!());
  
  return map.removeValues((Json json) => json.isString);
}
// #endregion base
// #endregion Json[string]

// #region Json
// #region indices
Json removeStrings(Json json, size_t[] indices, bool delegate(size_t) @safe removeFunc) {
  mixin(ShowFunction!());
  
  return json.removeIndices(indices, (size_t index) => json.getValue(index)
      .isString && removeFunc(index));
}

Json removeStrings(Json json, size_t[] indices) {
  mixin(ShowFunction!());

  return json.removeIndices(indices, (size_t index) => json[index].isString);
}

Json removeStrings(Json json, bool delegate(size_t) @safe removeFunc) {
  mixin(ShowFunction!());
  
  return json.removeIndices((size_t index) => json.getValue(index).isString && removeFunc(index));
}
// #endregion indices

// #region keys
Json removeStrings(Json json, string[] keys, bool delegate(string) @safe removeFunc) {
  mixin(ShowFunction!());
  
  return json.removeKeys(keys, (string key) => json[key].isString && removeFunc(key));
}

Json removeStrings(Json json, string[] keys) {
  mixin(ShowFunction!());

  return json.removeKeys(keys, (string key) => json.getValue(key).isString);
}

Json removeStrings(Json json, bool delegate(string) @safe removeFunc) {
  mixin(ShowFunction!());
  
  return json.removeKeys((string key) => json.getValue(key).isString && removeFunc(key));
}
// #endregion keys

// #region values
Json removeStrings(Json json, Json[] values, bool delegate(Json) @safe removeFunc) {
  mixin(ShowFunction!());

  return json.removeValues(values, (Json j) => j.isString && removeFunc(j));
}

Json removeStrings(Json json, Json[] values) {
  mixin(ShowFunction!());

  return json.removeValues(values, (Json j) => j.isString);
}

Json removeStrings(Json json, bool delegate(Json) @safe removeFunc) {
  mixin(ShowFunction!());

  return json.removeValues((Json j) => j.isString && removeFunc(j));
}
// #endregion values

// #region base
Json removeStrings(Json json) {
  mixin(ShowFunction!());

  return json.removeValues((Json j) => j.isString);
}
// #endregion base
// #endregion Json



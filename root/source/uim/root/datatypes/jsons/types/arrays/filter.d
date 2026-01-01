module uim.root.datatypes.jsons.types.arrays.filter;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

// #region Json[]
Json[] filterArrays(Json[] jsons, size_t[] indices, bool delegate(Json json) @safe filterFunc) {
  return jsons.filterValues(indices).filterArrays;
}

Json[] filterArrays(Json[] jsons, size_t[] indices) {
  return jsons.filterValues(indices).filterArrays;
}

Json[] filterArrays(Json[] jsons, bool delegate(Json json) @safe filterFunc) {
  return jsons.filterValues((Json json) => filterFunc(json)).filterArrays;
}

Json[] filterArrays(Json[] jsons) {
  return jsons.filterValues((Json json) => json.isArray);
}
// #region Json[]

// #region Json[string]
Json[string] filterArrays(Json[string] map, string[] keys, bool delegate(string) @safe filterFunc) {
  return map.filterKeys(keys, filterFunc).filterArrays;
}

Json[string] filterArrays(Json[string] map, string[] keys, bool delegate(Json) @safe filterFunc) {
  return map.filterKeys(keys).filterMap((Json json) => filterFunc(json)).filterArrays;
}

Json[string] filterArrays(Json[string] map, bool delegate(string, Json) @safe filterFunc) {
  return map.filterMap((string key, Json json) => filterFunc(key, json)).filterArrays;
}

Json[string] filterArrays(Json[string] map) {
  return map.filterMap((Json json) => json.isArray);
}
// #region Json[string]

// #region Json
Json filterArrays(Json json, size_t[] indices, bool delegate(Json json) @safe filterFunc) {
  return json.isArray ? json.filterArrays(indices).filterArrays(filterFunc) : Json(null);
}

Json filterArrays(Json json, size_t[] indices) {
  return json.isArray ? json.toArray.filterValues(indices).filterArrays.toJson : Json(null);
}

Json filterArrays(Json json, bool delegate(Json json) @safe filterFunc) {
  return json.isArray ? json.filterValues((Json json) => filterFunc(json)).filterArrays : Json(null);
}

/* 
Json filterArrays(Json json, string[] keys, bool delegate(string) @safe filterFunc) {
  return json.isObject ? json.filterKeys(keys)
    .filterValues((string key) => filterFunc(key)).filterArrays : Json(null);
}

Json filterArrays(Json json, string[] keys, bool delegate(Json) @safe filterFunc) {
  return json.isObject ? json.filterKeys(keys)
    .filterValues((Json json) => filterFunc(json)).filterArrays : Json(null);
}
* / 

Json filterArrays(Json json, bool delegate(string, Json) @safe filterFunc) {
  return json.isObject ? json.filterValues((string key, Json json) => filterFunc(key, json)).filterArrays
    : Json(null);
} */

Json filterArrays(Json json) {
  return json.isObject || json.isArray ? json.filterValues((Json json) => json.isArray) : Json(null);
}
// #region Json

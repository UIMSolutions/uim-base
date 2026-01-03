module uim.root.datatypes.jsons.types.booleans.filter;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

// #region Json[]
Json[] filterBooleans(Json[] jsons, size_t[] indices, bool delegate(Json) @safe filterFunc) {
  return jsons.filterValues(indices).filterBooleans;
}

Json[] filterBooleans(Json[] jsons, size_t[] indices) {
  return jsons.filterValues(indices).filterBooleans;
}

Json[] filterBooleans(Json[] jsons, bool delegate(Json) @safe filterFunc) {
  return jsons.filterValues((Json json) => filterFunc(json)).filterBooleans;
}

Json[] filterBooleans(Json[] jsons) {
  return jsons.filterValues((Json json) => json.isBoolean);
}
// #region Json[]

// #region Json[string]
Json[string] filterBooleans(Json[string] map, string[] keys, bool delegate(string) @safe filterFunc) {
  return map.filterBooleans(keys).filterBooleans(filterFunc);
}

Json[string] filterBooleans(Json[string] map, Json[] values, bool delegate(Json) @safe filterFunc) {
  return map.filterBooleans(values).filterBooleans(filterFunc);
}

Json[string] filterBooleans(Json[string] map, string[] keys) {
  return map.filterKeys(keys).filterBooleans;
}

Json[string] filterBooleans(Json[string] map, Json[] values) {
  return map.filterValues(values).filterBooleans;
}

Json[string] filterBooleans(Json[string] map, bool delegate(string) @safe filterFunc) {
  return map.filterMap((string key, Json json) => filterFunc(key)).filterBooleans;
}

Json[string] filterBooleans(Json[string] map, bool delegate(Json) @safe filterFunc) {
  return map.filterMap((string key, Json json) => filterFunc(json)).filterBooleans;
}

Json[string] filterBooleans(Json[string] map, bool delegate(string, Json) @safe filterFunc) {
  return map.filterMap((string key, Json json) => filterFunc(key, json)).filterBooleans;
}

Json[string] filterBooleans(Json[string] map) {
  return map.filterMap((string key, Json json) => json.isBoolean);
}
// #region Json[string]

// #region Json
Json filterBooleans(Json json, size_t[] indices, bool delegate(Json) @safe filterFunc) {
  return json.isBoolean ? json.filterBooleans(indices).filterBooleans(filterFunc) : Json(null);
}

Json filterBooleans(Json json, size_t[] indices) {
  return json.isBoolean ? json.toArray.filterValues(indices).filterBooleans.toJson : Json(null);
}

Json filterBooleans(Json json, bool delegate(Json) @safe filterFunc) {
  return json.isBoolean ? json.filterValues((Json json) => filterFunc(json)).filterBooleans : Json(null);
}

/* 
Json filterBooleans(Json json, string[] keys, bool delegate(string) @safe filterFunc) {
  return json.isObject ? json.filterKeys(keys)
    .filterValues((string key) => filterFunc(key)).filterBooleans : Json(null);
}

Json filterBooleans(Json json, string[] keys, bool delegate(Json) @safe filterFunc) {
  return json.isObject ? json.filterKeys(keys)
    .filterValues((Json json) => filterFunc(json)).filterBooleans : Json(null);
}
* / 

Json filterBooleans(Json json, bool delegate(string, Json) @safe filterFunc) {
  return json.isObject ? json.filterValues((string key, Json json) => filterFunc(key, json)).filterBooleans
    : Json(null);
} */

Json filterBooleans(Json json) {
  return json.isObject || json.isBoolean ? json.filterValues((Json json) => json.isBoolean) : Json(null);
}
// #region Json

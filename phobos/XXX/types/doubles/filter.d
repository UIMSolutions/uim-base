module uim.root.datatypes.jsons.types.doubles.filter;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:
/* 
// #region Json[]
// #region filter with indices and filterFunc(value)
Json[] filterDoubles(Json[] jsons, size_t[] indices, bool delegate(Json) @safe filterFunc) {
  return jsons.filterValues(indices).filterDoubles;
}
// #endregion filter with indices and filterFunc(value)

// #region filter with indices
Json[] filterDoubles(Json[] jsons, size_t[] indices) {
  return jsons.filterValues(indices).filterDoubles;
}
// #endregion filter with indices

// #region filter with filterFunc(value)
Json[] filterDoubles(Json[] jsons, bool delegate(Json) @safe filterFunc) {
  return jsons.filterValues((Json json) => filterFunc(json)).filterDoubles;
}

// #endregion filter with filterFunc(value)

// #region filter all Doubles
Json[] filterDoubles(Json[] jsons) {
  return jsons.filterValues((Json json) => json.isDouble);
}

// #endregion filter all Doubles
// #endregion Json[]

// #region Json[string]
// #region filter with keys and filterFunc(key)
Json[string] filterDoubles(Json[string] map, string[] keys, bool delegate(string) @safe filterFunc) {
  return map.filterDoubles(keys).filterDoubles(filterFunc);
}
// #endregion filter with keys and filterFunc(key)

// #region filter with values and filterFunc(value)
Json[string] filterDoubles(Json[string] map, Json[] values, bool delegate(Json) @safe filterFunc) {
  return map.filterDoubles(values).filterDoubles(filterFunc);
}
// #endregion filter with values and filterFunc(value)

// #region filter with keys
Json[string] filterDoubles(Json[string] map, string[] keys) {
  return map.filterKeys(keys).filterDoubles;
}
// #endregion filter with keys

// #region filter with values
Json[string] filterDoubles(Json[string] map, Json[] values) {
  return map.filterValues(values).filterDoubles;
}
// #endregion filter with values

// #region filter with filterFunc(key)
Json[string] filterDoubles(Json[string] map, bool delegate(string) @safe filterFunc) {
  return map.filterMap((string key, Json json) => filterFunc(key)).filterDoubles;
}
// #endregion filter with filterFunc(key)

// #region filter with filterFunc(value)
Json[string] filterDoubles(Json[string] map, bool delegate(Json) @safe filterFunc) {
  return map.filterMap((string key, Json json) => filterFunc(json)).filterDoubles;
}
// #endregion filter with filterFunc(value)

// #region filter with filterFunc(key, value)
Json[string] filterDoubles(Json[string] map, bool delegate(string, Json) @safe filterFunc) {
  return map.filterMap((string key, Json json) => filterFunc(key, json)).filterDoubles;
}
// #endregion filter with filterFunc(key, value)

// #region filter all Doubles
Json[string] filterDoubles(Json[string] map) {
  return map.filterMap((string key, Json json) => json.isDouble);
}
// #endregion filter all Doubles
// #endregion Json[string]

// #region Json
Json filterDoubles(Json json, size_t[] indices, bool delegate(Json) @safe filterFunc) {
  if (indices.length == 0) {
    return Json(null);
  }

  return json.filterValues(indices, (size_t index) => json.get(index).isDouble && filterFunc(json.get(index)));
}
// #endregion filter with indices and filterFunc(value)

// #region filter with indices
Json filterDoubles(Json json, size_t[] indices) {
  if (indices.length == 0) {
    return Json(null);
  }

  // For Json arrays, filtering by indices is applicable
  return json.isArray ? json.filterValues(indices).filterDoubles : Json(null);
}
// #endregion filter with indices

// #region filter with filterFunc(value)
Json filterDoubles(Json json, bool delegate(Json) @safe filterFunc) {
  if (json.isArray) {
    return json.filterValues((Json json) => json.isDouble &&filterFunc(json));
  }
  if (json.isObject) {
    return json.filterMap((string key, Json json) => json.isDouble &&filterFunc(json));
  }
  return Json(null);
}
// #endregion filter with filterFunc(value)

// #region filter all Doubles
Json filterDoubles(Json json) {
  if (json.isArray) {
    return json.filterValues((Json json) => json.isDouble);
  }
  if (json.isObject) {
    return json.filterMap((string key, Json json) => json.isDouble);
  }
  return Json(null);
}
// #endregion filter all Doubles
// #endregion Json
*/ 
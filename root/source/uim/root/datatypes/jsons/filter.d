module uim.root.datatypes.jsons.filter;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

// #region filterKeys
Json filterKeys(Json json, string[] keys, bool delegate(string) @safe filterFunc) {
  return json.isObject
    ? json.filterKeys(keys).filterKeys(filterFunc) : Json(null);
}

Json filterKeys(Json json, string[] keys) {
  return json.isObject
    ? json.filterKeys((string key) => json.hasKey(key)) : Json(null);
}

Json filterKeys(Json json, bool delegate(string) @safe filterFunc) {
  if (json.isObject) {
    Json(null);
  }
  Json result = Json.emptyObject;
  json.byKeyValue
    .filter!(kv => filterFunc(kv.key))
    .each!(kv => result[kv.key] = kv.value);
  return result;
}
// #endregion filterKeys

// #region filterValues
Json filterValues(Json json, size_t[] indices, bool delegate(Json) @safe filterFunc) {
  return json.filterValues(indices).filterValues(filterFunc);
}

Json filterValues(Json json, size_t[] indices) {
  Json result = Json.emptyArray;
  foreach(index, value; json.toArray) {
    if (hasValue(indices, index)) {
      result ~= value;
    }
  }
  return result;
}

Json filterValues(Json json, Json[] values, bool delegate(Json) @safe filterFunc) {
  return json.filterValues(values).filterValues(filterFunc);
}

Json filterValues(Json json, Json[] values) {
  return json.filterValues((Json value) => values.hasValue(value));
}

Json filterValues(Json json, bool delegate(Json) @safe filterFunc) {
  if (json.isArray) {
    return json.byValue.filter!(json => filterFunc(json)).array.toJson;
  } else if (json.isObject) {
    Json result = Json.emptyObject;
    json.byKeyValue
      .filter!(kv => filterFunc(kv.value))
      .each!(kv => result[kv.key] = kv.value);
    return result;
  }
  return Json(null);
}
// #endregion filterValues

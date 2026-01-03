module uim.root.datatypes.jsons.filter;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

// #region filterKeys
Json filterKeys(Json json, string[] keys, bool delegate(string) @safe filterFunc) {
  return json.filterMap((string key, Json value) => keys.hasValue(key) && filterFunc(key));
}

Json filterKeys(Json json, string[] keys) {
  return json.filterMap((string key, Json value) => keys.hasValue(key));
}

Json filterKeys(Json json, bool delegate(string) @safe filterFunc) {
  return json.filterMap((string key, Json value) => filterFunc(key));
}
// #endregion filterKeys

// #region filterMap
Json filterMap(Json json, string[] keys, bool delegate(string) @safe filterFunc) {
  return json.filterMap((string key, Json value) => json.hasKey(key) && filterFunc(key));
}

Json filterMap(Json json, Json[] values, bool delegate(Json) @safe filterFunc) {
  return json.filterMap((string key, Json value) => json.hasValue(value) && filterFunc(value));
}

Json filterMap(Json json, bool delegate(string, Json) @safe filterFunc) {
  if (!json.isObject) {
    return Json(null);
  }

  Json result = Json.emptyObject;
  json.byKeyValue
    .filter!(kv => filterFunc(kv.key, kv.value))
    .each!(kv => result[kv.key] = kv.value);
  return result;
}
// #endregion filterMap

// #region filterValues

Json filterValues(Json json, size_t[] indices, bool delegate(Json) @safe filterFunc) {
  if (json.isArray) {
    Json result = Json.emptyArray;
    foreach (index, value; json.toArray) {
      if (indices.hasValue(index) && filterFunc(value)) {
        result ~= value;
      }  
    }
    return result;
  } 
  return Json(null);
}

Json filterValues(Json json, size_t[] indices) {
  if (json.isArray) {
    Json result = Json.emptyArray;
    foreach (index, value; json.toArray) {
      if (indices.hasValue(index)) {
        result ~= value;
      }
    }
    return result;
  } 
  return Json(null);
}

Json filterValues(Json json, Json[] values, bool delegate(Json) @safe filterFunc) {
  if (json.isArray) {
    return json.byValue
      .filter!(json => values.hasValue(json) && filterFunc(json))
      .array
      .toJson;
  }
  if (json.isObject) {
    return json.filterMap((string key, Json json) => values.hasValue(json) && filterFunc(json));
  }
  return Json(null);
}

Json filterValues(Json json, Json[] values) {
  return json.filterValues((Json value) => values.hasValue(value));
}

Json filterValues(Json json, bool delegate(Json) @safe filterFunc) {
  if (json.isArray) {
    return json.byValue.filter!(json => filterFunc(json)).array.toJson;
  }
  if (json.isObject) {
    return json.filterMap((string key, Json json) => filterFunc(json));
  }
  return Json(null);
}
// #endregion filterValues

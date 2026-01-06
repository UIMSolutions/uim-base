module uim.root.datatypes.jsons.filter;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

/*
// #region Json
// #region paths
// #region with paths and filterFunc
Json filterPaths(Json json, string[][] paths, bool delegate(string[]) @safe filterFunc) {
  if (json.isObject) {
    return json.toMap.filterPaths(paths, filterFunc).toJson;
  }
  return Json(null);
}
// #endregion with paths and filterFunc

// #region with paths
Json filterPaths(Json json, string[][] paths) {
  if (json.isObject) {
    return json.toMap.filterPaths(paths).toJson;
  }
  return Json(null);
}
// #endregion with paths
// #endregion paths

// #region keys
// #region with keys and filterFunc
Json filterKeys(Json json, string[] keys, bool delegate(string) @safe filterFunc) {
  return json.isObject ? json.toMap.filterKeys(keys, filterFunc).toJson : Json(null);
}
// #endregion with keys and filterFunc

// #region with keys
Json filterKeys(Json json, string[] keys) {
  return json.isObject ? json.toMap.filterKeys(keys).toJson : Json(null);
}
// #endregion with keys

// #region with filterFunc
Json filterKeys(Json json, bool delegate(string) @safe filterFunc) {
  return json.isObject ? json.toMap.filterKeys(filterFunc).toJson : Json(null);
}
// #endregion with filterFunc
// #endregion keys

// #region values
// #region with values and filterFunc
Json filterValues(Json json, Json[] values, bool delegate(Json) @safe filterFunc) {
  if (json.isArray) {
    return json.toArray.filterValues(values, filterFunc).toJson;
  }
  if (json.isObject) {
    return json.toMap.filterValues(values, filterFunc).toJson;
  }
  return Json(null);
}
// #endregion with values and filterFunc

// #region with values
Json filterValues(Json json, Json[] values) {
  if (json.isArray) {
    return json.toArray.filterValues(values).toJson;
  }
  if (json.isObject) {
    return json.toMap.filterValues(values).toJson;
  }
  return Json(null);
}
// #endregion with values

// #region with filterFunc(value)
Json filterValues(Json json, bool delegate(Json) @safe filterFunc) {
  if (json.isArray) {
    return json.toArray.filterValues(filterFunc).toJson;
  }
  if (json.isObject) {
    return json.toMap.filterValues(filterFunc).toJson;
  }
  return Json(null);
}
// #endregion with filterFunc(value)
// #endregion values

// #region indices
// #region with indices and filterFunc
Json filterValues(Json json, size_t[] indices, bool delegate(size_t) @safe filterFunc) {
  if (json.isArray) {
    return json.toArray.filterIndices(indices, filterFunc).toJson;
  }
  return Json(null);
}
// #endregion with indices and filterFunc

// #region with indices
Json filterValues(Json json, size_t[] indices) {
  if (json.isArray) {
    return json.toArray.filterIndices(indices).toJson;
  }
  return Json(null);
}
// #endregion with indices

// #region with filterFunc
Json filterValues(Json json, bool delegate(size_t) @safe filterFunc) {
  if (json.isArray) {
    return json.toArray.filterIndices(filterFunc).toJson;
  }
  return Json(null);
}
// #endregion with filterFunc
// #endregion indices
// #endregion Json

// #region Json[string]
// #region paths
// #region with paths and filterFunc
Json[string] filterPaths(Json[string] map, string[][] paths, bool delegate(string[]) @safe filterFunc) {
  Json[string] result;
  foreach (path; paths) {
    if (map.hasPath(path) && filterFunc(path)) {
      result.setValue(path, map.getValue(path));
    }
  }
  return result;
}
// #endregion with paths and filterFunc

// #region with paths
Json[string] filterPaths(Json[string] map, string[][] paths) {
  Json[string] result;
  foreach (path; paths) {
    if (map.hasPath(path)) {
      result.setValue(path, map.getValue(path));
    }
  }
  return result;
}
// #endregion with paths
// #endregion paths

// #region keys
// #region with keys and filterFunc
Json[string] filterKeys(Json[string] map, string[] keys, bool delegate(string) @safe filterFunc) {
  Json[string] result;
  foreach (key; keys) {
    if (map.hasKey(key) && filterFunc(key)) {
      result[key] = map[key];
    }
  }
  return result;
}
// #endregion with keys and filterFunc

// #region with keys
Json[string] filterKeys(Json[string] map, string[] keys) {
  Json[string] result;
  foreach (key; keys) {
    if (map.hasKey(key)) {
      result[key] = map[key];
    }
  }
  return result;
}
// #endregion with keys

// #region with filterFunc
Json[string] filterKeys(Json[string] map, bool delegate(string) @safe filterFunc) {
  Json[string] result;
  foreach (key; map.keys) {
    if (filterFunc(key)) {
      result[key] = map[key];
    }
  }
  return result;
}
// #endregion with filterFunc
// #endregion keys

// #region values
// #region with values and filterFunc
Json[string] filterValues(Json[string] map, Json[] values, bool delegate(Json) @safe filterFunc) {
  Json[string] result;
  foreach (key, value; map.byKeyValue) {
    if (values.hasValue(value) && filterFunc(value)) {
      result[key] = value;
    }
  }
  return result;
}
// #endregion with values and filterFunc

// #region with values
Json[string] filterValues(Json[string] map, Json[] values) {
  Json[string] result;
  foreach (key, value; map.byKeyValue) {
    if (values.hasValue(value)) {
      result[key] = value;
    }
  }
  return result;
}
// #endregion with values

// #region with filterFunc
Json[string] filterValues(Json[string] map, bool delegate(Json) @safe filterFunc) {
  Json[string] result;
  foreach (key, value; map.byKeyValue) {
    if (filterFunc(value)) {
      result[key] = value;
    }
  }
  return result;
}
// #endregion with filterFunc
// #endregion values
// #endregion Json[string]

// #region Json[]
// #region indices
// #region with indices and filterFunc
Json[] filterIndices(Json[] jsons, size_t[] indices, bool delegate(size_t) @safe filterFunc) {
  Json[] result;
  foreach (index, value; jsons) {
    if (indices.hasValue(index) && filterFunc(index)) {
      result ~= value;
    }
  }
  return result;
}
// #endregion with indices and filterFunc

// #region with indices
Json[] filterIndices(Json[] jsons, size_t[] indices) {
  Json[] result;
  foreach (index, value; jsons) {
    if (indices.hasValue(index)) {
      result ~= value;
    }
  }
  return result;
}
// #endregion with indices

// #region with filterFunc
Json[] filterIndices(Json[] jsons, bool delegate(size_t) @safe filterFunc) {
  Json[] result;
  foreach (index, value; jsons) {
    if (filterFunc(index)) {
      result ~= value;
    }
  }
  return result;
}
// #endregion filterFunc
// #endregion indices

// #region values
// #region with values and filterFunc
Json[] filterValues(Json[] jsons, Json[] values, bool delegate(Json) @safe filterFunc) {
  Json[] result;
  foreach (value; jsons) {
    if (values.hasValue(value) && filterFunc(value)) {
      result ~= value;
    }
  }
  return result;
}
// #endregion with values and filterFunc

// #region with values
Json[] filterValues(Json[] jsons, Json[] values) {
  Json[] result;
  foreach (value; jsons) {
    if (values.hasValue(value)) {
      result ~= value;
    }
  }
  return result;
}
// #endregion with values

// #region with filterFunc
Json[] filterValues(Json[] jsons, bool delegate(Json) @safe filterFunc) {
  Json[] result;
  foreach (value; jsons) {
    if (filterFunc(value)) {
      result ~= value;
    }
  }
  return result;
}
// #endregion with filterFunc
// #endregion values
// #endregion Json[]
*/
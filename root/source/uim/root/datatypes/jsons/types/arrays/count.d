module uim.root.datatypes.jsons.types.arrays.count;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

// #region Json[]
size_t countArrays(Json[] jsons, size_t[] indices) {
  return indices.filter!(index => jsons.isArray(index)).array.length;
}

size_t countArrays(Json[] jsons, bool delegate(Json) @safe countFunc) {
  return jsons.filter!(json => countFunc(json)).array.length;
}
// #endregion Json[]

// #region Json[string]
size_t countArrays(Json[string] map, string[][] paths) {
  return paths.filter!(path => map.isArray(path)).array.length;
}

size_t countArrays(Json[string] map, string[] keys) {
  return keys.filter!(key => map.isArray(key)).array.length;
}

size_t countArrays(Json[string] map, bool delegate(string) @safe countFunc) {
  return map.byKeyValue.filter!(kv => countFunc(kv.key)).array.length;
}

size_t countArrays(Json[string] map, bool delegate(Json) @safe countFunc) {
  return map.byKeyValue.filter!(kv => countFunc(kv.value)).array.length;
}

size_t countArrays(Json[string] map, bool delegate(string, Json) @safe countFunc) {
  return map.byKeyValue.filter!(kv => countFunc(kv.key, kv.value)).array.length;
}
// #endregion Json[string]

// #region Json
size_t countArrays(Json json, size_t[] indices) {
  return json.isArray ? indices.filter!(index => json.isArray(index)).array.length : 0;
}

size_t countArrays(Json json, string[][] paths) {
  return json.isObject ? paths.filter!(path => json.isArray(path)).array.length : 0;
}

size_t countArrays(Json json, string[] keys) {
  return json.isObject ? keys.filter!(key => json.isArray(key)).array.length : 0;
}

size_t countArrays(Json json, bool delegate(string) @safe countFunc) {
  return json.isObject ? json.byKeyValue.filter!(kv => countFunc(kv.key)).array.length : 0;
}

size_t countArrays(Json json, bool delegate(Json) @safe countFunc) {
  if (json.isArray) {
    return json.byValue.filter!(value => countFunc(value)).array.length;
  }
  if (json.isObject) {
    return json.byKeyValue.filter!(kv => countFunc(kv.value)).array.length;
  }
  return 0;
}

size_t countArrays(Json json, bool delegate(string, Json) @safe countFunc) {
  return json.isObject ? json.byKeyValue.filter!(kv => countFunc(kv.key, kv.value)).array.length : 0;
}
// #endregion Json[string]

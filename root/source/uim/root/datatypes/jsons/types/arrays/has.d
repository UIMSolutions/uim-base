module uim.root.datatypes.jsons.types.arrays.has;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

// #region Json[]
bool hasAllArrays(Json[] jsons, size_t[] indices) {
  return indices.all!(index => jsons.isArray(index));
}

bool hasAnyArrays(Json[] jsons, size_t[] indices) {
  return indices.any!(index => jsons.isArray(index));
}
// #endregion Json[]

// #region Json[string]
bool hasAllArrays(Json[string] map, string[][] paths) {
  return paths.all!(path => map.isArray(path));
}

bool hasAnyArrays(Json[string] map, string[][] paths) {
  return paths.any!(path => map.isArray(path));
}

bool hasAllArrays(Json[string] map, string[] keys) {
  return keys.all!(key => map.isArray(key));
}

bool hasAnyArrays(Json[string] map, string[] keys) {
  return keys.any!(key => map.isArray(key));
}
// #endregion Json[string]

// #region Json
bool hasAllArrays(Json json, size_t[] indices) {
  return json.isArray ? indices.all!(index => json.isArray(index)) : false;
}

bool hasAnyArrays(Json json, size_t[] indices) {
  return json.isArray ? indices.any!(index => json.isArray(index)) : false;
}

bool hasAllArrays(Json json, string[][] paths) {
  return json.isObject ? paths.all!(path => json.isArray(path)) : false;
}

bool hasAnyArrays(Json json, string[][] paths) {
  return json.isObject ? paths.any!(path => json.isArray(path)) : false;
}

bool hasAllArrays(Json json, string[] keys) {
  return json.isObject ? keys.all!(key => json.isArray(key)) : false;
}

bool hasAnyArrays(Json json, string[] keys) {
  return json.isObject ? keys.any!(key => json.isArray(key)) : false;
}
// #endregion Json
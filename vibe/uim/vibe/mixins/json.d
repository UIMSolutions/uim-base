/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.mixins.json;

template CheckJsonIs(string type) {
  const char[] CheckJsonIs = `
// #region Json[string]
bool isAll`~type~`(Json[string] map, bool strict = true) {
  return map.byValue.all!(value => value.is`~type~`(strict));
}

bool isAll`~type~`(Json[string] map, string[] keys, bool strict = true) {
  return keys.all!(key => map.is`~type~`(key, strict));
}

bool isAny`~type~`(Json[string] map, bool strict = true) {
  return map.byValue.any!(value => value.is`~type~`(strict));
}

bool isAny`~type~`(Json[string] map, string[] keys, bool strict = true) {
  return keys.any!(index => map.is`~type~`(index));
}

bool is`~type~`(Json[string] map, string key, bool strict = true) {
  return key in map && map[key].is`~type~`(strict);
}
// #endregion Json[string]

// #region Json[]
bool isAll`~type~`(Json[] values, bool strict = true) {
  return values.all!(value => value.is`~type~`(strict));
}

bool isAll`~type~`(Json[] values, size_t[] indices, bool strict = true) {
  return indices.all!(index => values.is`~type~`(index, strict));
}

bool isAny`~type~`(Json[] values, bool strict = true) {
  return values.any!(value => value.is`~type~`(strict));
}

bool isAny`~type~`(Json[] values, size_t[] indices, bool strict = true) {
  return indices.any!(index => values.is`~type~`(index, strict));
}

bool is`~type~`(Json[] values, size_t index, bool strict = true) {
  return values.length > index && values[index].is`~type~`(strict);
}
// #endregion Json[]

// #region Json
bool isAll`~type~`(Json json, bool strict = true) {
  if (json.isObject) {
    return isAll`~type~`(json.to!(Json[string]), strict); 
  }
  if (json.isArray) {
    return isAll`~type~`(json.to!(Json[]), strict); 
  }
  return json.is`~type~`(strict); 
}

bool isAll`~type~`(Json json, string[] keys, bool strict = true) {
  return keys.all!(key => json.is`~type~`(key, strict));
}

bool isAny`~type~`(Json json, bool strict = true) {
  if (json.isObject) {
    return isAny`~type~`(json.to!(Json[string]), strict); 
  }
  if (json.isArray) {
    return isAny`~type~`(json.to!(Json[]), strict); 
  }
  return json.is`~type~`(strict); 
}

bool isAny`~type~`(Json json, string[] keys, bool strict = true) {
  return keys.any!(key => json.is`~type~`(key, strict));
}

bool is`~type~`(Json json, string key, bool strict = true) {
  return key in json && json[key].is`~type~`(strict);
}
// #endregion Json
`;
}

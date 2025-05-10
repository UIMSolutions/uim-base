/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.mixins.json;

string isJsonFunctions(string target) {
  return `
// #region Json[string]
bool isAlltarget(Json[string] map, bool strict = true) {
  return map.byValue.all!(value => value.is{target}(strict));
}

bool isAlltarget(Json[string] map, string[] keys, bool strict = true) {
  return keys.all!(key => map.is{target}(key, strict));
}

bool isAnytarget(Json[string] map, bool strict = true) {
  return map.byValue.any!(value => value.is{target}(strict));
}

bool isAnytarget(Json[string] map, string[] keys, bool strict = true) {
  return keys.any!(index => map.is{target}(index));
}

bool is{target}(Json[string] map, string key, bool strict = true) {
  return key in map && map[key].is{target}(strict);
};
// #endregion Json[string]

// #region Json[]
bool isAll{target}(Json[] values, bool strict = true) {
  return values.all!(value => value.is{target}(strict));
}

bool isAll{target}(Json[] values, size_t[] indices, bool strict = true) {
  return indices.all!(index => values.is{target}(index, strict));
}

bool isAny{target}(Json[] values, bool strict = true) {
  return values.any!(value => value.is{target}(strict));
}

bool isAny{target}(Json[] values, size_t[] indices, bool strict = true) {
  return indices.any!(index => values.is{target}(index, strict));
}

bool is{target}(Json[] values, size_t index, bool strict = true) {
  return values.length > index && values[index].is{target}(strict);
}
// #endregion Json[]

// #region Json
bool isAll{target}(Json json, bool strict = true) {
  if (json.isObject) {
    return isAll{target}(json.to!(Json[string]), strict); 
  }

  if (json.isArray) {
    return isAll{target}(json.to!(Json[]), strict); 
  }

  return json.is{target}(strict); 
}

bool isAll{target}(Json json, string[] keys, bool strict = true) {
  return keys.all!(key => json.is{target}(key, strict));
}

bool isAny{target}(Json json, bool strict = true) {
  if (json.isObject) {
    return isAny{target}(Json json, bool strict = true) {
  }

  if (json.isArray) {
    return isAny{target}(Json json, bool strict = true) {
  }

  return json.is{target}(strict); 
}

bool isAny{target}(Json json, string[] keys, bool strict = true) {
  return keys.any!(key => json.is{target}(key, strict));
}

bool is{target}(Json json, string[] path, bool strict = true) { 
  if (!json.isObject) {
    return false;
  }

  if (path.length == 0) {
    return json.is{target}(strict);
  }
    
  auto key = path[0];
  return path.length == 1
    ? json.is{target}(key, strict) 
    : json.hasKey(key) && json[key].is{target}(path[1 .. $], strict);
}

bool is{target}(Json json, string key, bool strict = true) {
  return key in json && json[key].is{target}(strict);
}
// #endregion Json
`;
}

template IsJsonFunctions(string target) {
  const char[] IsJsonFunctions = isJsonFunctions(target);
}

template GetJsonValue(string type, string typeName, string defaultValue) {
  const char[] GetJsonValue = `
` ~ type ~ ` get` ~ typeName ~ `(Json json, size_t index, ` ~ type ~ ` defaultValue = ` ~ defaultValue ~ `) {
  return json.isArray 
    ? get`
    ~ typeName ~ `(json.get!(Json[]), index, defaultValue)
    : defaultValue;
}

` ~ type ~ ` get` ~ typeName ~ `(Json json, string key, ` ~ type ~ ` defaultValue = ` ~ defaultValue ~ `) {
  return json.isObject
    ? get`
    ~ typeName ~ `(json.get!(Json[string]), index, defaultValue)
    : defaultValue;
}

` ~ type ~ ` get` ~ typeName ~ `(Json[string] map, string key, ` ~ type ~ ` defaultValue = ` ~ defaultValue ~ `) {
  return key in map
    ? map[key].get`
    ~ typeName ~ ` : defaultValue;
}

` ~ type ~ ` get` ~ typeName ~ `(Json[] values, size_t index, ` ~ type ~ ` defaultValue = ` ~ defaultValue ~ `) {
  return values.length > index
    ? values[index].get`
    ~ typeName ~ ` : defaultValue;
}
  `;
}

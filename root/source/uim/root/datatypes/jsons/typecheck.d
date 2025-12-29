/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.typecheck;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

// #region isArray
bool isArray(Json json, size_t index) {
  return json.isArray && index < json.length && json[index].isArray;
}

bool isArray(Json json, string key) {
  return json.isObject && json.hasKey(key) && json[key].isArray;
}

bool isArray(Json json) {
  return (json.type == Json.Type.array);
}
// #endregion isArray

// #region isObject
bool isObject(Json json, size_t index) {
  return json.isArray && index < json.length && json[index].isObject;
}

bool isObject(Json json, string key) {
  return json.isObject && json.hasKey(key) && json[key].isObject;
}

bool isObject(Json json) {
  return (json.type == Json.Type.object);
}
// #endregion isObject

bool isBoolean(Json json, size_t index) {
  return json.isArray && index < json.length && json[index].isBoolean;
}

bool isBoolean(Json json, string key) {
  return json.isObject && json.hasKey(key) && json[key].isBoolean;
}

bool isBoolean(Json json) {
  return (json.type == Json.Type.bool_);
}

bool isInteger(Json json, size_t index) {
  return json.isArray && index < json.length && json[index].isInteger;
}

bool isInteger(Json json, string key) {
  return json.isObject && json.hasKey(key) && json[key].isInteger;
}

bool isInteger(Json json) {
  return (json.type == Json.Type.int_);
}

bool isDouble(Json json, size_t index) {
  return json.isArray && index < json.length && json[index].isDouble;
}

bool isDouble(Json json, string key) {
  return json.isObject && json.hasKey(key) && json[key].isDouble;
}

bool isDouble(Json json) {
  return (json.type == Json.Type.float_);
}

bool isString(Json json, size_t index) {
  return json.isArray && index < json.length && json[index].isString;
}

bool isString(Json json, string key) {
  return json.isObject && json.hasKey(key) && json[key].isString;
}

bool isString(Json json) {
  return (json.type == Json.Type.string);
}

bool isNull(Json json, size_t index) {
  return json.isArray && index < json.length && json[index].isNull;
}

bool isNull(Json json, string key) {
  return json.isObject && json.hasKey(key) && json[key].isNull;
}

bool isNull(Json json) {
  return json == Json(null); 
}

bool isUndefined(Json json, size_t index) {
  return json.isArray && index < json.length && json[index].isUndefined;
}

bool isUndefined(Json json, string key) {
  return json.isObject && json.hasKey(key) && json[key].isUndefined;
}

bool isUndefined(Json json) {
  return json.type == Json.Type.undefined; 
}
/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.algorithms.comparisons;

mixin(Version!("test_uim_vibe"));

import uim.vibe;

@safe:

// #region isAll
bool isAll(Json json, bool delegate(string key, Json value) @safe func) {
  if (!json.isObject) {
    return false;
  }

  return json.byKeyValue.all!(kv => func(kv.key, kv.value));
}

bool isAll(Json json, bool delegate(string key) @safe func) {
  if (!json.isObject) {
    return false;
  }

  return json.byKeyValue.all!(kv => func(kv.key));
}

bool isAll(Json json, bool delegate(Json value) @safe func) {
  if (!json.isObject && !json.isArray) {
    return false;
  }

  return json.byValue.all!(value => func(value));
}

unittest { // isAll(Json, delegate(string, Json))
  // Prepare a Json object
  auto obj = Json.emptyObject;
  obj["a"] = 1;
  obj["b"] = 2;
  obj["c"] = 3;

  assert(obj.isAll((string key, Json value) => key.length + value.get!int > 0));
  assert(obj.isAll((string key) => key.length > 0));
  assert(obj.isAll((Json value) => value.get!int > 0));

  auto list = Json.emptyArray;
  list ~= 1;
  list ~= 2;
  list ~= 3;
  assert(list.isAll((Json value) => value.get!int > 0));
}
// #endregion isAll


// #region isAny
bool isAny(Json json, bool delegate(string key, Json value) @safe func) {
  if (!json.isObject) {
    return false;
  }

  return json.byKeyValue.any!(kv => func(kv.key, kv.value));
}

bool isAny(Json json, bool delegate(string key) @safe func) {
  if (!json.isObject) {
    return false;
  }

  return json.byKeyValue.any!(kv => func(kv.key));
}

bool isAny(Json json, bool delegate(Json value) @safe func) {
  if (!json.isObject && !json.isArray) {
    return false;
  }

  return json.byValue.any!(value => func(value));
}

unittest { // isAny(Json, delegate(string, Json))
  // Prepare a Json object
  auto obj = Json.emptyObject;
  obj["a"] = 1;
  obj["b"] = 2;
  obj["c"] = 3;

  assert(obj.isAny((string key, Json value) => key.length + value.get!int > 0));
  assert(obj.isAny((string key) => key.length > 0));
  assert(obj.isAny((Json value) => value.get!int > 0));

  auto list = Json.emptyArray;
  list ~= 1;
  list ~= 2;
  list ~= 3;
  assert(list.isAny((Json value) => value.get!int > 0));
}
// #endregion isAny

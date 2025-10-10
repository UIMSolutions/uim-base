/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.algorithms.iterations.every;

import uim.vibe;

mixin(Version!("test_uim_vibe"));
@safe:

/** 
  * Iterates over each key-value pair in a JSON object or each value in a JSON array, applying the provided delegate function.
  *
  * Params:
  *   data = The JSON data to iterate over (can be an array or an object).
  *   func = A delegate function that takes a key and a value as its parameters.
  */
void every(Json data, void delegate(string key, Json value) @safe func) {
  if (data.isObject) {
    data.byKeyValue.each!(kv => func(kv.key, kv.value));
  }
}

/**
  * Iterates over each element in a JSON array or each value in a JSON object, applying the provided delegate function.
  *
  * Params:
  *   data = The JSON data to iterate over (can be an array or an object).
  *   func = A delegate function that takes a single Json value as its parameter.
  */
void every(Json json, void delegate(Json value) @safe func) {
  if (json.isArray || json.isObject) {
    json.byValue.each!(value => func(value));
  }
}

void everyKey(Json json, void delegate(string key) @safe func) {
  if (json.isObject) {
    json.byKeyValue.each!(kv => func(kv.key));
  }
}

void everyValue(Json json, void delegate(Json value) @safe func) {
  if (json.isArray || json.isObject) {
    json.byValue.each!(v => func(v));
  }
}

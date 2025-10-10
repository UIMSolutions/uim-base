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
    return data.toMap.every(func);
  }
}

/**
  * Iterates over each element in a JSON array or each value in a JSON object, applying the provided delegate function.
  *
  * Params:
  *   data = The JSON data to iterate over (can be an array or an object).
  *   func = A delegate function that takes a single Json value as its parameter.
  */
void every(Json data, void delegate(Json value) @safe func) {
  if (data.isArray) {
    return data.toArray.every(func);
  }
}

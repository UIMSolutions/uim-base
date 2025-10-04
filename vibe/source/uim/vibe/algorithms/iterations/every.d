/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.algorithms.iterations.every;

import uim.vibe;
mixin(Version!("test_uim_vibe"));

@safe:

void every(Json data, void delegate(string key, Json value) @safe func) {
  if (!data.isObject) {
    return;
  }
  data.byKeyValue.each!(kv => func(kv.key, kv.value));
}

void every(Json data, void delegate(string key) @safe func) {
  if (!data.isObject) {
    return;
  }
  data.byKeyValue.each!(kv => func(kv.key));
}

void every(Json data, void delegate(Json value) @safe func) {
  if (!data.isObject && !data.isArray) {
    return;
  }
  data.byValue.each!(v => func(v));
}

unittest {
  Json list = Json.emptyArray;
  list ~= 1; list ~= 2; list ~= 3;

  int buffer;
  list.every((Json value) { buffer += value.get!int; });
  assert(buffer == 6);
}

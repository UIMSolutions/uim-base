module uim.vibe.algorithms.iterations;

mixin(Version!("test_uim_vibe"));

import uim.vibe;

@safe:

void every(Json json, void delegate(string key, Json value) @safe func) {
  if (!json.isObject) {
    return;
  }
  json.byKeyValue.each!(kv => func(kv.key, kv.value));
}

void every(Json json, void delegate(string key) @safe func) {
  if (!json.isObject) {
    return;
  }
  json.byKeyValue.each!(kv => func(kv.key));
}

void every(Json json, void delegate(Json value) @safe func) {
  if (!json.isObject && !json.isArray) {
    return;
  }
  json.byValue.each!(v => func(v));
}

unittest {
  int buffer;
  json list = json.emptyObject;
  list ~= 1; list ~= 2; list ~= 3;
  [1, 2, 3].every((int value) => buffer += value.get!int);
  assert(buffer == 6);
}

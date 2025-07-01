module uim.vibe.algorithms.iterations;

mixin(Version!("test_uim_vibe"));

import uim.vibe;

@safe:

T first(T)(T[] values) {
  return (values.length > 0) 
    ? values[0]
    : Null!T;  
}

T last(T)(T[] values) {
  return (values.length > 0) 
    ? values[$-1]
    : Null!T;  
}

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

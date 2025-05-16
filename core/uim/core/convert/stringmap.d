module uim.core.convert.stringmap;

mixin(Version!("test_uim_core"));

import uim.core;
@safe:

STRINGAA toStringMap(Json[string] map) {
  STRINGAA stringMap;
  map.byKeyValue
    .each!(kv => stringMap[kv.key] = kv.value.to!string);
  return stringMap;
}

unittest {
  Json[string] jsonMap = [
    "key1": Json("value1"),
    "key2": Json("value2")
  ];

  STRINGAA expectedStringMap = [
    "key1": "value1",
    "key2": "value2"
  ];

  assert(toStringMap(jsonMap) == expectedStringMap);
}

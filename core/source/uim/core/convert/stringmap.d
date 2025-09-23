module uim.core.convert.stringmap;

mixin(Version!("test_uim_core"));

import uim.core;
@safe:

STRINGAA toStringMap(Json[string] items) {
  STRINGAA results;
  items.each!((key, value) { results[key] = value.to!string; });
  return results;
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

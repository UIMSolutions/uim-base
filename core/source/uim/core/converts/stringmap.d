/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.core.converts.stringmap;

import uim.core;

mixin(ShowModule!());
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

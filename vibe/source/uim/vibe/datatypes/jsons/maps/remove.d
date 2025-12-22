/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.maps.remove;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

/// Remove all key-value pairs from the map.
Json[string] removeAll(Json[string] map) {
  // Collect keys first to avoid mutating during iteration
  auto keys = map.keys.array;
  keys.each!(key => map.remove(key));
  return map;
}

/// Remove the specified keys from the map.
Json[string] remove(Json[string] map, string[] keys) {
  keys.each!(key => map.remove(key));
  return map;
}

/// Remove the specified key from the map.
Json[string] remove(Json[string] map, string key) {
  if (map is null) {
    return map;
  }

  if (key in map) {
    map.remove(key);
  }
  return map;
}

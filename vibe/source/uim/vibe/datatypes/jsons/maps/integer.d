/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.maps.integer;

import uim.vibe;
mixin(Version!("test_uim_vibe"));

@safe:

bool allInteger(Json[string] map, bool strict = true) {
  return map.byValue.all!(value => value.isInteger(strict));
}

/// Check if all specified keys in the map are integers.
bool allInteger(Json[string] map, string[] keys, bool strict = true) {
  return keys.all!(key => map.isInteger(key, strict));
}

/// Check if any value in the map is an integer.
bool anyInteger(Json[string] map, bool strict = true) {
  return map.byValue.any!(value => value.isInteger(strict));
}

/// Check if any of the specified keys in the map is an integer.
bool anyInteger(Json[string] map, string[] keys, bool strict = true) {
  return keys.any!(index => map.isInteger(index));
}

/// Check if the value associated with the specified key in the map is an integer.
bool isInteger(Json[string] map, string key, bool strict = true) {
  return key in map && map[key].isInteger(strict);
}


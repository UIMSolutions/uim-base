/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.contains;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

/// Returns true if the given JSON value contains all of the given values.
bool containsAll(Json json, Json[] values) {
  return json.isNull
    ? false
    : values.all!(value => json.contains(value));
}

/// Returns true if the given JSON value contains at least one of the given values.
bool containsAny(Json json, Json[] values) {
  return json.isNull
    ? false
    : values.any!(value => json.contains(value));
}

/// Returns true if the given JSON value contains the given value.
bool contains(Json json, Json value) {
  if (json.isNull) return false;

  return json == value;
}


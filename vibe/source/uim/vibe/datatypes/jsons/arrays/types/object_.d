/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.object_;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

bool allObject(Json[] values) {
  return values.all!(value => uim.vibe.datatypes.jsons.json.types.object_.isObject(value));
}

bool allObject(Json[] values, size_t[] indices) {
  return indices.all!(index => values.isObject(index));
}

bool anyObject(Json[] values) {
  return values.any!(value => uim.vibe.datatypes.jsons.json.types.object_.isObject(value));
}

bool anyObject(Json[] values, size_t[] indices) {
  return indices.any!(index => values.isObject(index));
}

bool isObject(Json[] values, size_t index) {
  if (index >= values.length) {
    return false;
  } 

  return uim.vibe.datatypes.jsons.json.types.object_.isObject(values[index]);
}

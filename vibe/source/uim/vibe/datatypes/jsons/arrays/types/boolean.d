/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.boolean;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

bool allBoolean(Json[] values) {
  return values.all!(value => value.isBoolean);
}

bool allBoolean(Json[] values, size_t[] indices) {
  return indices.all!(index => values.isBoolean(index));
}

bool anyBoolean(Json[] values) {
  return values.any!(value => value.isBoolean);
}

bool anyBoolean(Json[] values, size_t[] indices) {
  return indices.any!(index => values.isBoolean(index));
}

bool isBoolean(Json[] values, size_t index) {
  if (index >= values.length) {
    return false;
  } 

  return values[index].isBoolean;
}
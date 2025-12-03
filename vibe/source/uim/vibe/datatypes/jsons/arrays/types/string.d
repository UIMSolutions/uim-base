/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.string;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

bool allString(Json[] values) {
  return values.all!(value => value.isString);
}

bool allString(Json[] values, size_t[] indices) {
  return indices.all!(index => values.isString(index));
}

bool anyString(Json[] values) {
  return values.any!(value => value.isString);
}

bool anyString(Json[] values, size_t[] indices) {
  return indices.any!(index => values.isString(index));
}

bool isString(Json[] values, size_t index) {
  if (index >= values.length) {
    return false;
  } 

  return values[index].isString;
}
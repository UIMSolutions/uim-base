/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.null_;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

bool allNull(Json[] values) {
  return values.all!(value => value.isNull);
}

bool allNull(Json[] values, size_t[] indices) {
  return indices.all!(index => values.isNull(index));
}

bool anyNull(Json[] values) {
  return values.any!(value => value.isNull);
}

bool anyNull(Json[] values, size_t[] indices) {
  return indices.any!(index => values.isNull(index));
}

bool isNull(Json[] values, size_t index) {
  if (index >= values.length) {
    return false;
  } 

  return values[index].isNull;
}

/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.nulls.is_;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

bool isAllNull(Json[] values, size_t[] indices) {
  return indices.all!(index => values.isNull(index));
}

bool isAnyNull(Json[] list, size_t[] indices) {
  return list.isNull
    ? false
    : indices.any!(index => list.isNull(index));
}

bool isNull(Json[] values, size_t index) {
  if (index >= values.length) {
    return false;
  } 

  return uim.vibe.datatypes.jsons.json.types.nulls.isNull(values[index]);
}

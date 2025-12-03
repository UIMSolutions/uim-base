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
  return values.all!(value => value.isObject);
}

bool allObject(Json[] values, size_t[] indices) {
  return indices.all!(index => values.isObject(index));
}

bool anyObject(Json[] values) {
  return values.any!(value => value.isObject);
}

bool anyObject(Json[] values, size_t[] indices) {
  return indices.any!(index => values.isObject(index));
}

bool isObject(Json[] values, size_t index) {
  if (index >= values.length) {
    return false;
  } 

  return values[index].isObject;
}

/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.objects.is_;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:


bool isAllObject(Json[] values) {
  return values.all!(value => uim.vibe.datatypes.jsons.json.types.objects.isObject(value));
}

bool isAllObject(Json[] values, size_t[] indices) {
  return indices.all!(index => values.isObject(index));
}

bool isAnyObject(Json[] values) {
  return values.any!(value => uim.vibe.datatypes.jsons.json.types.objects.isObject(value));
}

bool isAnyObject(Json[] values, size_t[] indices) {
  return indices.any!(index => values.isObject(index));
}

bool isObject(Json[] values, size_t index) {
  if (index >= values.length) {
    return false;
  } 

  return uim.vibe.datatypes.jsons.json.types.objects.isObject(values[index]);
}

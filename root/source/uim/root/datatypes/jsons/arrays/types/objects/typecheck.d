/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.arrays.types.objects.typecheck;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

bool isAllObject(Json[] values) {
  return values.all!(value => isObject(value));
}

bool isAllObject(Json[] values, size_t[] indices) {
  return indices.all!(index => values.isObject(index));
}

bool isAnyObject(Json[] values) {
  return values.any!(value => isObject(value));
}

bool isAnyObject(Json[] values, size_t[] indices) {
  return indices.any!(index => values.isObject(index));
}

bool isObject(Json[] values, size_t index) {
  if (index >= values.length) {
    return false;
  } 

  return isObject(values[index]);
}

/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.undefined;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

bool allUndefined(Json[] values) {
  return values.all!(value => uim.vibe.datatypes.jsons.json.types.undefined.isUndefined(value));
}

bool allUndefined(Json[] values, size_t[] indices) {
  return indices.all!(index => values.isUndefined(index));
}

bool anyUndefined(Json[] values) {
  return values.any!(value => uim.vibe.datatypes.jsons.json.types.undefined.isUndefined(value));
}

bool anyUndefined(Json[] values, size_t[] indices) {
  return indices.any!(index => values.isUndefined(index));
}

bool isUndefined(Json[] values, size_t index) {
  if (index >= values.length) {
    return false;
  } 

  return uim.vibe.datatypes.jsons.json.types.undefined.isUndefined(values[index]);
}

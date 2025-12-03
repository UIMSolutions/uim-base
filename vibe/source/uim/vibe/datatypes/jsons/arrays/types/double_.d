/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.double_;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

bool allDouble(Json[] values) {
  return values.all!(value => value.isDouble);
}

bool allDouble(Json[] values, size_t[] indices) {
  return indices.all!(index => values.isDouble(index));
}

bool anyDouble(Json[] values) {
  return values.any!(value => value.isDouble);
}

bool anyDouble(Json[] values, size_t[] indices) {
  return indices.any!(index => values.isDouble(index));
}
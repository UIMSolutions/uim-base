/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.integer;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

bool allInteger(Json[] values) {
  return values.all!(value => value.isInteger);
}

bool allInteger(Json[] values, size_t[] indices) {
  return indices.all!(index => values.isInteger(index));
}

bool anyInteger(Json[] values) {
  return values.any!(value => value.isInteger);
}

bool anyInteger(Json[] values, size_t[] indices) {
  return indices.any!(index => values.isInteger(index));
}
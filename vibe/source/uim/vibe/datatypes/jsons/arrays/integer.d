/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.integer;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

bool allInteger(Json[] values, bool strict = true) {
  return values.all!(value => value.isInteger(strict));
}

bool allInteger(Json[] values, size_t[] indices, bool strict = true) {
  return indices.all!(index => values.isInteger(index, strict));
}

bool anyInteger(Json[] values, bool strict = true) {
  return values.any!(value => value.isInteger(strict));
}

bool anyInteger(Json[] values, size_t[] indices, bool strict = true) {
  return indices.any!(index => values.isInteger(index, strict));
}

bool isInteger(Json[] values, size_t index, bool strict = true) {
  return values.length > index && values[index].isInteger(strict);
}
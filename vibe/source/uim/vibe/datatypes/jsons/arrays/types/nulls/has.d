/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.nulls.has;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

bool hasOnlyNull(Json[] values) {
  return values.all!(value => uim.vibe.datatypes.jsons.json.types.nulls.isNull(value));
}

bool hasAnyNull(Json[] values) {
  return values.any!(value => uim.vibe.datatypes.jsons.json.types.nulls.isNull(value));
}
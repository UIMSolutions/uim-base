/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.json.convert;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

Json[] toArray(Json value) {
  if (value.isNull) {
    return null;
  }

  return value.isArray
    ? value.get!(Json[]) : null;
}

Json[] toMap(Json value) {
  if (value.isNull) {
    return null;
  }

  return value.isObject
    ? value.get!(Json[string]) : null;
}

Json[] toObject(Json value) {
  if (value.isNull) {
    return null;
  }

  return value.isObject
    ? value.get!(Json[string]) : null;
}
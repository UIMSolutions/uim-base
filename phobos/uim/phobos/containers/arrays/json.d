/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.phobos.containers.arrays.json;

mixin(Version!("test_uim_core"));

import uim.phobos;
@safe:
// to Json array

Json[] toJsonArray(T)(T[] values) {
  return values.map!(value => value.toJson).array;
}


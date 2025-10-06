/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.phobos.arrays.first;

import uim.phobos;

mixin(Version!("test_uim_phobos"));
@safe:

T first(T)(T value) if (!isArray!T) {
  return value;
}

T first(T)(T value) if (isArray!T) {
  return value.length > 0 
  ? value[0]
  : Null!T;
}

T first(T : string)(T value) {
  return value;
}
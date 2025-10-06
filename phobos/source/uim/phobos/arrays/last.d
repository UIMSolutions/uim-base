/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.phobos.arrays.last;

import uim.phobos;

mixin(Version!("test_uim_phobos"));
@safe:

T last(T)(T value) if (!isArray!T) {
  return value;
}

T last(T)(T value) if (isArray!T) {
  return value.length > 0
  ? value[$-1]
  : Null!T;
}

T last(T : string)(T value) {
  return value;
}

/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.phobos.containers.arrays.last;

import uim.phobos;

mixin(Version!("test_uim_phobos"));
@safe:

auto last(T)(T[] values) {
  return values.length > 0 
    ? values[$-1]
    : Null!T;
}

auto lastMany(T)(T[] values, size_t size) {
  if (values.length == 0) {
    return null;
  }

  return values.length > size
    ? values[$-size..$]
    : values.dup;
}

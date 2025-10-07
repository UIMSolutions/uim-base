/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.phobos.containers.arrays.rest;

import uim.phobos;

mixin(Version!("test_uim_phobos"));
@safe:

auto rest(T)(T[] values) {
  return values.length > 1 
    ? values[1 .. $]
    : null;
}
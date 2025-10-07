/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.phobos.containers.maps.pairs;

import uim.phobos;

mixin(Version!("test_uim_phobos"));
@safe:

auto pairs(K, V)(K[] keys, V[] values) {
  auto minLength = min(keys.length, values.length);
  return keys.take(minLength).zip(values.take(minLength)).array;
}
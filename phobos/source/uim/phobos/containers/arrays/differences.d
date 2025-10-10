/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.phobos.containers.arrays.differences;

import uim.phobos;

mixin(Version!("test_uim_phobos"));
@safe:

auto differences(T)(T[] arr1, T[] arr2) {
  import std.algorithm : setDifference;
  import std.array : array;
  return arr1.setDifference(arr2).array;
}


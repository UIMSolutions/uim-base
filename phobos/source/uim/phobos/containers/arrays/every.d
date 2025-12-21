/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.phobos.containers.arrays.every;

import uim.phobos;

mixin(Version!"test_uim_phobos");

@safe:

void every(V)(auto ref V[] items, void delegate(V value) @safe func) {
  items.each!(v => func(v));
}


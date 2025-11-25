/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.lists.interfaces;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

interface IList(V) : ICollection!V {
  // Get an item by its index.
  V getValue(size_t index);
}


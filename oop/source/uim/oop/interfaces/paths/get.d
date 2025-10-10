/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.interfaces.paths.get;

mixin(Version!"test_uim_oop");

import uim.oop;

@safe:

interface IGetPaths(T) {
  // Gets a specific item from the collection.
  T itemByPath(string[] path);
}

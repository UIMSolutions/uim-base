/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.interfaces.paths.get;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

// Interface for getting items by paths.
interface IGetPaths(K = string, V = UIMObject) {
  // Gets multiple items from the collection.
  V[K] values(K[][] paths);

  // Gets a specific item from the collection.
  V value(K[] path);
}

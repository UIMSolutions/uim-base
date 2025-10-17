/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.interfaces.paths.get;

mixin(Version!"test_uim_oop");

import uim.oop;
@safe:

// Interface for getting items by paths.
interface IGetPath(K, V) {
  // Gets multiple items from the collection.
  V getManyPath(K[][] paths);

  // Gets a specific item from the collection.
  V getPath(K[] path);
}

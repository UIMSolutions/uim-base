/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.interfaces.paths.remove;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

// Interface for removing items by paths.
interface IRemovePaths(K) {
  // Removes all of the given paths from the collection.
  bool removeAllPath(K[][] paths);

  // Removes any of the given paths from the collection.
  bool removeAnyPath(K[][] paths);

  // Removes a specific path from the collection.
  bool removePath(K[] path);
}

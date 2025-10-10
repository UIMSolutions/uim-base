/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.interfaces.paths.has;

mixin(Version!"test_uim_oop");

import uim.oop;

@safe:

interface IHasPaths(T) {
  // Checks if the collection contains the specified items. 
  bool hasAllPath(string[][] paths);

  // Checks if the collection contains any of the specified items.
  bool hasAnyPath(string[][] paths);

  // Checks if the collection contains a specific item.
  bool hasPath(string[] path);
}

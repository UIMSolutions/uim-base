/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.interfaces.paths.has;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

// Interface for checking the existence of paths.
interface IHasPaths(K) {
  // Checks if contains all of the paths.
  bool hasAllPath(K[][] paths);

  // Checks if contains any of the paths.
  bool hasAnyPath(K[][] paths);

  // Checks if contains a specific path.
  bool hasPath(K[] path);
}

/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.directories.interfaces;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

// Interface for directories maps.
interface IDirectory(V = UIMObject) : IMap!(string, V), IHasPaths!string, IGetPaths!(string, V), IChangePaths!(string, V), IRemovePaths!string {
  // Gets the path separator used in the directories.
  bool pathSeparator(string separator);

  // Sets the path separator used in the directories.
  string pathSeparator();

  // Gets all paths in the map, sorted according to the specified order.
  // string[][] paths();
}

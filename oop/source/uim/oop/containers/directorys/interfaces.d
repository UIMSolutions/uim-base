/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.directorys.interfaces;

mixin(Version!"test_uim_oop");

import uim.oop;
@safe:

// Interface for directory maps.
interface IDirectoryMap(V) : IMap!(string, V), IHasPaths!string, IGetPath!(string, V), IChangePaths!(string, V), IRemovePath!string {
  // Gets the path separator used in the directory.
  bool pathSeparator(string separator);

  // Sets the path separator used in the directory.
  string pathSeparator();

  // Gets all paths in the map, sorted according to the specified order.
  string[][] paths();
}

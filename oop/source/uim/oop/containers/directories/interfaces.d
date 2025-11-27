/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.directories.interfaces;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

/// Interface for directories maps.
interface IDirectory(V = UIMObject) : IMap!(string, V), IPaths!(string, V) {
  // Gets the path separator used in the directories.
  void pathSeparator(string separator);

  // Sets the path separator used in the directories.
  string pathSeparator();

  // Gets all paths in the map, sorted according to the specified order.
  // string[][] paths();

  V[] values(string[][] paths);
  V[] values(string[] keys = null);

  V value(string[] path);
  V value(string key);

  V opCall(string[] path);
  V opCall(string key);

  void opCall(string[] path, V value);
  void opCall(V[string] entries);
}

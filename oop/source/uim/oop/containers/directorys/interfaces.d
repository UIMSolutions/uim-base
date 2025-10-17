/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.directorys.interfaces;

mixin(Version!"test_uim_oop");

import uim.oop;
@safe:

interface IDirectoryMap(V) : IMap!(string, V) {

  // Gets the path separator used in the directory.
  bool pathSeparator(string separator);
  // Sets the path separator used in the directory.
  string pathSeparator();

  // Gets all paths in the map, sorted according to the specified order.
  string[][] paths();

  // #region has
  // Checks if all specified paths exist in the map.
  bool hasAllPath(string[][] paths);
  // Checks if any of the specified paths exist in the map.
  bool hasAnyPath(string[][] paths);
  // Checks if a specific path exists in the map.
  bool hasPath(string[] path);
  // #endregion has

  // #region get
  // Gets the entire map as a map of paths to items.
  V[string] getManyPath(string[][] paths); 
  V getPath(string[] path); 

  // #region set
  // Sets the entire map to the specified item.
  bool setPaths(string[][] paths, T item);
  // Sets a specific item in the map.
  bool setPath(string[] path, T item);
  // #endregion set

  // #region update
  bool updatePaths(string[][] paths, T item);
  // Updates a specific item in the map.
  bool updatePath(string[] path, T item);
  // #endregion update

  // #region merge
  // Merges the entire map with the specified item.
  bool mergePaths(string[][] paths, T item);
  // Merges a specific item into the map.
  bool mergePath(string[] path, T item);
  // #endregion merge

  // #region remove
  // Removes all specified paths were 
  bool removeAllPaths(string[][] paths);
  // Removes any specified paths were found
  bool removeAnyPaths(string[][] paths);
  // Removes a specific item from the map.
  bool removePath(string[] path);
  // #endregion remove
}

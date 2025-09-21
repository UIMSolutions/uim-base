/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.interfaces.paths.update;

mixin(Version!"test_uim_oop");

import uim.oop;

@safe:

interface IUpdatePaths(T) {
  // #region set
  // Sets the entire collection to the specified items.
  bool setPaths(T[string[]] items);
  bool setPaths(string[][] paths,  T items);

  // Sets a specific item in the collection.
  bool setPath(string[] path, T item);
  // #endregion set

  // #region update
  // Updates the entire collection to the specified items.
  bool updatePaths(T[string[]] items);
  bool updatePaths(string[][] paths,  T items);

  // Updates a specific item in the collection.
  bool updatePath(string[] path, T item);
  // #endregion update

  // #region merge
  // Merges the entire collection with the specified items.
  bool mergePaths(T[string[]] items);
  bool mergePaths(string[][] paths,  T items);

  // Merges a specific item into the collection.
  bool mergePath(string[] path, T item);
  // #endregion merge
}

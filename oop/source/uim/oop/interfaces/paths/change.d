/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.interfaces.paths.change;

mixin(Version!"test_uim_oop");

import uim.oop;
@safe:

interface IChangePaths(K, V) {
  // #region set
  // Sets all of the specified items in the collection.
  bool setAllPath(K[][] paths, V item);
  
  // Sets any of the specified items in the collection.
  bool setAnyPath(K[][] paths, V item);

  // Sets a specific item in the collection.
  bool setPath(K[] path, V item);
  // #endregion set

  // #region update
  // Updates all of the specified items in the collection.
  bool updateAllPath(K[][] paths, V item);

  // Updates any of the specified items in the collection.
  bool updateAnyPath(K[][] paths, V item);

  // Updates a specific item in the collection.
  bool updatePath(K[] path, V item);
  // #endregion update

  // #region merge
  // Merges all of the specified items into the collection.
  bool mergeAllPath(K[][] paths, V item);

  // Merges any of the specified items into the collection.
  bool mergeAnyPath(K[][] paths, V item);

  // Merges a specific item into the collection.
  bool mergePath(K[] path, V item);
  // #endregion merge
}

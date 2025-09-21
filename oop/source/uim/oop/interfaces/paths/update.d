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
    bool setPath(T[string[]] items);

    // Sets a specific item in the collection.
    bool setPath(string[] path, T item);
  // #endregion set

  // #region update
    // Updates the entire collection to the specified items.
    bool updatePath(T[string[]] items);

    // Updates a specific item in the collection.
    bool updatePath(string[] path, T item);
  // #endregion update

  // #region merge
    // Merges the entire collection with the specified items.
    bool mergePath(T[string[]] items);

    // Merges a specific item into the collection.
    bool mergePath(string[] path, T item);
  // #endregion merge
}

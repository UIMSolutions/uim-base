/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.interfaces.paths.get;

mixin(Version!"test_uim_oop");

import uim.oop;

@safe:

interface IPaths(T) {
  string[][] paths(SORTORDERS sortorder = NOSORT);

  // #region has
    // Checks if the collection contains the specified items. 
    bool hasAllPath(string[][] paths);

    // Checks if the collection contains any of the specified items.
    bool hasAnyPath(string[][] paths);

    // Checks if the collection contains a specific item.
    bool hasPath(string[] path);
  // #endregion has

  // #region get
    // Gets the entire collection as a map of paths to items.
    T[string[]] items(string[][] paths);

    // Gets a specific item from the collection.
    T item(string[] path);
  // #endregion get

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

  // #region remove
    // Removes the given paths from the collection.
    bool removePaths(string[][] paths);

    // Removes a specific path from the collection.
    bool removePath(string[] path);
  // #endregion remove
}

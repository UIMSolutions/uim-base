/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.interfaces.keys;

mixin(Version!"test_uim_oop");

import uim.oop;
@safe:

interface IKeys(T) {
  // Returns an array containing all of the keys in this collection.
  string[] keys(SORTORDERS sortorder = NOSORT);

  // Converts a path (array of strings) to a key (string).
  string pathToKey(string[] path);

  // #region has
    // Checks if the collection contains all keys.
    bool hasAllKey(string[] keys);

    // Checks if the collection contains any of the given keys.
    bool hasAnyKey(string[] keys);

    // Checks if the collection contains a specific key.
    bool has(string key);
  // #endregion has

  // #region set
    // Adds all given items to the collection.
    bool set(T[string] items);

    // Adds a specific item to the collection.
    bool set(string key, T item);
  // #endregion set

  // #region update
    // Updates all given items in the collection.
    bool update(T[string] items);

    // Updates a specific item in the collection.
    bool update(string key, T item);
  // #endregion update  

  // #region merge
    // Merges all given items into the collection.
    bool merge(T[string] items);

    // Merges a specific item into the collection.
    bool merge(string key, T item);
  // #endregion merge   

  // #region remove
    // Removes all keys from the collection.
    bool removeAll();

    // Removes the given keys from the collection.
    bool remove(string[] keys);

    // Removes a specific key from the collection.
    bool remove(string key);
  // #endregion remove
}


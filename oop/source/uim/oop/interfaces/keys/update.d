/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.interfaces.keys.update;

mixin(Version!"test_uim_oop");

import uim.oop;

@safe:

interface IUpdateKeys(T) {
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
}

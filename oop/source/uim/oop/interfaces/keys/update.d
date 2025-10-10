/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
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
  bool setKeys(T[string] items);
  bool setKeys(string[] keys, T items);

  // Adds a specific item to the collection.
  bool setKey(string key, T item);
  // #endregion set

  // #region update
  // Updates all given items in the collection.
  bool updateKeys(T[string] items);
  bool updateKeys(string[] keys, T items);

  // Updates a specific item in the collection.
  bool updateKey(string key, T item);
  // #endregion update

  // #region merge
  // Merges all given items into the collection.
  bool mergeKeys(T[string] items);  
  bool mergeKeys(string[] keys, T items);

  // Merges a specific item into the collection.
  bool mergeKey(string key, T item);
  // #endregion merge
}

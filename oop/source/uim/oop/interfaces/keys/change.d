/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.interfaces.keys.change;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

// Interface for updating items by their keys.
interface IChangeKeys(K = string, V = UIMObject) {
  // #region set
  // Adds all given items to the collection.
  bool setAllKey(V[K] items);
  
  // Adds all given items to the collection.
  bool setAllKey(K[] keys, V newValue);

  // Adds any of the given items to the collection.
  bool setAnyKey(V[K] items);

  // Adds any of the given items to the collection.
  bool setAnyKey(K[] keys, V newValue);

  // Adds a specific item to the collection.
  bool setKey(K key, V newValue);
  // #endregion set

  // #region update
  // Updates all given items in the collection.
  bool updateAllKey(V[K] items);

  // Updates all given items in the collection.
  bool updateAllKey(K[] keys, V newValue);

  // Updates any of the given items in the collection.
  bool updateAnyKey(V[K] items);

  // Updates any of the given items in the collection.
  bool updateAnyKey(K[] keys, V newValue);

  // Updates a specific item in the collection.
  bool updateKey(K key, V newValue);
  // #endregion update

  // #region merge
  // Merges all given items into the collection.
  bool mergeAllKey(V[K] items);
  
  // Merges all given items into the collection.
  bool mergeAllKey(K[] keys, V itemnewValues);

  // Merges any of the given items into the collection.
  bool mergeAnyKey(V[K] items);

  // Merges any of the given items into the collection.
  bool mergeAnyKey(K[] keys, V newValue);

  // Merges a specific item into the collection.
  bool mergeKey(K key, V newValue);
  // #endregion merge
}

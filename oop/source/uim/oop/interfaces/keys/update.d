/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.interfaces.keys.update;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

// Interface for updating items by their keys.
interface IChangeKeys(K = string, V = UIMObject) {
  // #region set
  // Adds all given items to the collection.
  bool setAllKey(V[K] items);
  
  // Adds all given items to the collection.
  bool setAKey(K[] keys, V items);

  // Adds any of the given items to the collection.
  bool setAnyKey(V[K] items);

  // Adds any of the given items to the collection.
  bool setAnyKey(K[] keys, V items);

  // Adds a specific item to the collection.
  bool setKey(K key, V llitem);
  // #endregion set

  // #region update
  // Updates all given items in the collection.
  bool updateAllKey(V[K] items);

  // Updates all given items in the collection.
  bool updateAllKeys(K[] keys, V items);

  // Updates any of the given items in the collection.
  bool updateAnyKey(V[K] items);

  // Updates any of the given items in the collection.
  bool updateAnyKeys(K[] keys, V items);

  // Updates a specific item in the collection.
  bool updateKey(K key, V item);
  // #endregion update

  // #region merge
  // Merges all given items into the collection.
  bool mergeAllKey(V[K] items);
  
  // Merges all given items into the collection.
  bool mergeAllKey(K[] keys, V items);

  // Merges any of the given items into the collection.
  bool mergeAnyKey(V[K] items);

  // Merges any of the given items into the collection.
  bool mergeAnyKey(K[] keys, V items);

  // Merges a specific item into the collection.
  bool mergeKey(K key, V item);
  // #endregion merge
}

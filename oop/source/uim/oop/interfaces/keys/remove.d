/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.interfaces.keys.remove;

mixin(Version!"test_uim_oop");

import uim.oop;

@safe:

// Interface for removing items by their keys.
interface IRemoveAllKeys(K = string) {
  // Removes all of the given keys from the collection.
  bool removeAllKey(K[] keys);

  // Removes any of the given keys from the collection.
  bool removeAnyKey(K[] keys);

  // Removes a specific key from the collection.
  bool removeKey(K key);
}

/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.interfaces.keys.has;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

interface IHasKeys(K = string) {
  // Checks if the collection contains all keys.
  bool hasAllKey(K[] keys);

  // Checks if the collection contains any of the given keys.
  bool hasAnyKey(K[] keys);

  // Checks if the collection contains a specific key.
  bool hasKey(K key);
}

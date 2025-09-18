/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.interfaces.keys.has;

mixin(Version!"test_uim_oop");

import uim.oop;

@safe:

interface IHasKeys(T) {
  // Checks if the collection contains all keys.
  bool hasAllKey(string[] keys);

  // Checks if the collection contains any of the given keys.
  bool hasAnyKey(string[] keys);

  // Checks if the collection contains a specific key.
  bool has(string key);
}

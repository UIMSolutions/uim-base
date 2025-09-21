/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.registries.interfaces;

mixin(Version!"test_uim_oop");

import uim.oop;
@safe:

interface IRegistry(T) : IKeys, IPaths {
  // Registers an object with a specific key.
  void register(string key, T obj);

  // Unregisters an object by its key.
  bool unregister(string key);

  // Retrieves an object by its key.
  T get(string key);

  // Checks if a key is registered.
  bool has(string key);
}
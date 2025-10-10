/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.registries.interfaces;

import uim.oop;

mixin(Version!"test_uim_oop");
@safe:

interface IRegistry(T = UIMObject) : IHasKeys!T, IHasPaths!T, IObject {
  // Registers an object with a specific key.
  bool register(string[] path, T obj);
  bool register(string key, T obj);

  // Unregisters an object by its key.
  bool unregisterAll();

  bool unregisterMany(string[][] paths);
  bool unregisterMany(string[] keys);

  bool unregister(string[] path);
  bool unregister(string key);

  // Retrieves an object by its key.
  T getPath(string[] path);
  T getKey(string key);

  // Retrieves an object by its key.
  bool removePath(string[] path);
  bool removeKey(string key);
}

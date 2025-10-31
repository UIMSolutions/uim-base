/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.registries.interfaces;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

interface IRegistry(V = IObject) : IHasKeys!string, IHasPaths!string, IObject {
  // Registers an object with a specific key.
  bool register(string[] path, V obj);
  bool register(string key, V obj);

  bool unregisterMany(string[][] paths);
  bool unregisterMany(string[] keys);

  bool unregister(string[] path);
  bool unregister(string key);

  // Retrieves an object by its key.
  V value(string[] path);
  V value(string key);
}

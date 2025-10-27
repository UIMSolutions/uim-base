/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.registries.interfaces;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

interface IRegistry(K = string, V = IObject) : IHasKeys!K, IHasPaths!K, IObject {
  // Registers an object with a specific key.
  bool register(K[] path, V obj);
  bool register(K key, V obj);

  bool unregisterMany(K[][] paths);
  bool unregisterMany(K[] keys);

  bool unregister(K[] path);
  bool unregister(K key);

  // Retrieves an object by its key.
  V getPath(K[] path);
  V getKey(K key);
}

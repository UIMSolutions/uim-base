/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.registries.interfaces;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

interface IRegistry(V = UIMObject) : IHasKeys!(string, V), IHasPaths!(string, V), IGetValues!(string, V), IObject {
  // #region paths
  bool register(string[] path, V obj);

  bool unregisterAll(string[][] paths);
  bool unregisterAny(string[][] paths);
  bool unregister(string[] path);
  // #endregion paths

  // #region keys
  bool register(string key, V obj);

  bool unregisterAll(string[] keys);
  bool unregisterAny(string[] keys);
  bool unregister(string key);
  // #endregion keys
}

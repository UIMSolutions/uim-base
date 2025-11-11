/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.configurations.engines.interfaces;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

// An interface for creating objects compatible with Configure.load()
interface IConfigEngine : IDirectory!Json {
  string[] keys();
  // #endregion read methods
}

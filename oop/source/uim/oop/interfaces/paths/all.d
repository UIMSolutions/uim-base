/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.interfaces.paths.all;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

interface IPaths(K = string, V = UIMObject) : IHasPaths!K, IGetPaths!(K, V), IChangePaths!(K, V), IRemovePaths!K {
  string[][] paths();
}

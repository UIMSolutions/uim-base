/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.interfaces.keys.get;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

interface IGetKeys(K = string, V = UIMObject) {
  K[] keys();
}

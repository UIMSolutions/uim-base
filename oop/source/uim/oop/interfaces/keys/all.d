/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.interfaces.keys.all;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

interface IKeys(K = string, V = UIMObject) : IHasKeys!(K), IGetKeys!(K, V), IChangeKeys!(K, V), IRemoveAllKeys!(K) {
  // Returns an array containing all of the keys in this collection.
  K[] keys();
}


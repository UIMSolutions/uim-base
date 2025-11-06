
/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.interfaces.values.get;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

interface IGetValues(K = string, V = UIMObject) {
  V[] values();
  V[] values(K[][] paths);
  V[] values(K[] keys);

  V value(K[] path);
  V value(K key);
}
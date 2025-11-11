
/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.interfaces.values.remove;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

interface IRemoveValues(K = string, V = UIMObject) {
  bool removeAllValue(V[] values);
  bool removeAnyValue(V[] values);
  bool removeValue(V value);
}
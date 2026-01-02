/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.interfaces.values.has;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

interface IHasValues(K = string, V = UIMObject) {
  bool hasAllValue(V[] values);
  bool hasAnyValue(V[] values);
  bool hasValue(V value);
}
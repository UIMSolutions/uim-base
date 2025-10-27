/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.maps.tests.test;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

bool testMap(K, V)(IMap!(K, V) map, string instanceName) {
  assert(map !is null, instanceName ~ " map is null");
  
  return true;
}
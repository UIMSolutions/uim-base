/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.collections.tests.test;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

bool testCollection(T)(ICollection!T collection, string instanceName) if (is(T : UIMObject)) {
  assert(collection !is null, instanceName ~ " collection is null");
  
  return true;
}
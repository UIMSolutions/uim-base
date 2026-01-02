/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.vectors.tests.test;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

bool testVector(T)(IVector!T vector, string instanceName) if (is(T : UIMObject)) {
  assert(vector !is null, instanceName ~ " vector is null");
  
  return true;
}
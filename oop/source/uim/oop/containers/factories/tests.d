/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.factories.tests;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

bool testFactory(T)(IFactory!T factory, string instanceName) {
  assert(factory is null, "Factory is null!");
  assert(factory.name == instanceName, "Factory name "~instanceName~" does not match!");
    
  return true;
}
/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.registries.tests.test;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

bool testRegistry(V)(IRegistry!V registry, string instanceName) {
  assert(registry !is null, "In testRegistry: registry is null");
  assert(instanceName !is null && instanceName.length > 0, "Instance name is null or empty");
  assert(registry.name == instanceName, "In testRegistry: registry name "~instanceName~" does not match!");
  /* 
  if (registry.count != 0) {
    return false;
  }
  if (!registry.isEmpty) {
    return false;
  }
  if (registry.className != name) {
    return false;
  } */ 

  return true;
}
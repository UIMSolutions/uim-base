/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.registries.tests;

import uim.oop;

mixin(Version!"test_uim_oop");
@safe:

bool testRegistry(IRegistry!UIMObject registry, string name) {
  if (registry is null) {
    return false;
  }
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
/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.sets.tests.test;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

bool testSet(T)(ISet!T set, string instanceName) {
  assert(set !is null, instanceName ~ " set is null");
  assert(instanceName !is null && instanceName.length > 0, "Instance name is null or empty");
  // assert(set.name == instanceName, "In testSet: set name "~instanceName~" does not match!");

  return true;
}
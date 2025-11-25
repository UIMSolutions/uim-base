/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.lists.tests.test;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

bool testList(T)(IList!T list, string instanceName) {
  assert(list !is null, instanceName ~ " list is null");
  assert(instanceName !is null && instanceName.length > 0, "Instance name is null or empty");
  // TODO: assert(list.name == instanceName, "In testList: list name "~instanceName~" does not match!");

  return true;
}
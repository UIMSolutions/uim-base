/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.directorys.tests.test;

mixin(Version!"test_uim_oop");

import uim.oop;
@safe:

bool testDirectory(T)(IDirectory!T directory, string instanceName) if (is(T : UIMObject)) {
  assert(directory !is null, instanceName ~ " directory is null");
  return true;
}
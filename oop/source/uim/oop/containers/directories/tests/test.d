/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.directoriess.tests.test;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

// Tests the given directories instance.
bool testDirectories(V)(IDirectory!V directories, string instanceName) if (is(T : UIMObject)) {
  assert(directories !is null, instanceName ~ " directories is null");
  return true;
}
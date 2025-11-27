/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.directories.tests.test;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

bool testDirectory(V)(IDirectory!V directory, string instanceName) {
  assert(directory !is null, "In testDirectory:" ~ instanceName ~ " directory is null");
  return true;
}
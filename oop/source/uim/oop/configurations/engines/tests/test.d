/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.configurations.engines.tests.test;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

bool testConfigEngine(IConfigEngine ConfigEngine) {
  assert(ConfigEngine !is null, "In testConfigEngine: ConfigEngine is null");

  return true;
}
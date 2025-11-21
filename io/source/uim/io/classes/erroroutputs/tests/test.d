/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.erroroutputs.tests.test;

import uim.io;

mixin(Version!"test_uim_io");
@safe:

bool testErrorOutput(IErrorOutput output) {
  assert(output !is null, "In testErrorOutput: output is null");

  // assert(output.engine("default") !is null, "In testErrorOutput: default engine is null");

  return true;
}

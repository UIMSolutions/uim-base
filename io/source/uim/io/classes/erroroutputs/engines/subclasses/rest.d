/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.classes.erroroutputs.engines.subclasses.rest;

import uim.io;

mixin(Version!"test_uim_io");
@safe:

class DRestErrorOutput:  DErrorOutputEngine {
  mixin(ErrorOutputEngineThis!("Rest"));
}
mixin(ErrorOutputEngineCalls!("Rest"));

unittest {
  auto output = RestErrorOutput();   
  assert(testErrorOutput(output));

  assert(output.name == "RestErrorOutput");
}
/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.classes.error.engines.rest;

import uim.io;
@safe:

mixin(Version!"test_uim_io");

import uim.io;
@safe:


class DRestErrorOutput:  DErrorOutputEngine {
  mixin(ErrorOutputThis!("Rest"));
}
mixin(ErrorOutputCalls!("Rest"));

unittest {
  auto output = RestErrorOutput();   
  assert(testErrorOutput(output));

  assert(output.name == "RestErrorOutput");
}
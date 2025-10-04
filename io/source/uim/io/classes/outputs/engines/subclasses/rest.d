/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt rest.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.classes.outputs.engines.subclasses.rest;

mixin(Version!"test_uim_io");

import uim.io;
@safe:


class DRestOutputEngine : DOutputEngine {
  mixin(OutputEngineThis!("Rest"));
}

mixin(OutputEngineCalls!("Rest"));

unittest {
  auto engine = new DRestOutputEngine();
  assert(engine !is null, "DRestOutputEngine is null");

  assert(testOutputEngine(engine, "RestOutputEngine"), "Test DRestOutputEngine failed");  
}
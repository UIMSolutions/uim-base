/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt rest.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.consoles.classes.outputs.engines.rest;

mixin(Version!"test_uim_io");

import uim.consoles;
@safe:


class DRestOutputEngine : DOutputEngine {
  mixin(OutputEngineThis!("Rest"));
}

mixin(OutputEngineCalls!("Rest"));

unittest {
  auto output = RestOutputEngine;
  assert(testOutputEngine(output));
}


/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt rest.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.configurations.engines.subclasses.rest;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

class DRestConfigEngine : DConfigEngine {
  mixin(ConfigEngineThis!("Rest"));

  override IConfigEngine clone() {
    return new DRestConfigEngine();
  }
  }

mixin(ConfigEngineCalls!("Rest"));

unittest {
  auto engine = new DRestConfigEngine();
  assert(testConfigEngine(engine, "Rest"), "Test of RestConfigEngine failed!");
}

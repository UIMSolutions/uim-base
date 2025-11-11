/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.configurations.engines.subclasses.file;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

class DFileConfigEngine : DConfigEngine {
  mixin(ConfigEngineThis!("File"));

  override IConfigEngine clone() {
    return new DFileConfigEngine();
  }
}

mixin(ConfigEngineCalls!("File"));

unittest {
  auto engine = new DFileConfigEngine();
  assert(testConfigEngine(engine, "File"), "Test of FileConfigEngine failed!");
}

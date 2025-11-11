/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt yaml.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.configurations.engines.subclasses.yaml;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

class DYamlConfigEngine : DConfigEngine {
  mixin(ConfigEngineThis!("Yaml"));

  override IConfigEngine clone() {
    return new DYamlConfigEngine();
  }
}

mixin(ConfigEngineCalls!("Yaml"));

unittest {
  auto engine = new DYamlConfigEngine();
  assert(testConfigEngine(engine, "Yaml"), "Test of YamlConfigEngine failed!");
}

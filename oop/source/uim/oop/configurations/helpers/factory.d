/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.configurations.helpers.factory;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

class DConfigurationFactory : DFactory!IConfiguration {
  mixin(FactoryThis!("Configuration"));
}

mixin(FactoryCalls!("Configuration"));

unittest {
  auto factory = new DConfigurationFactory();
  assert(testFactory(factory, "Configuration"), "Test of DConfigurationFactory failed!");
}

static this() {
  ConfigurationFactory.set("memory", (Json[string] options = null) @safe {
    auto config = new DConfiguration();
    return config.engine(ConfigEngineFactory.create("memory"));
  });

  ConfigurationFactory.set("file", (Json[string] options = null) @safe {
    auto config = new DConfiguration();
    return config.engine(ConfigEngineFactory.create("file"));
  });

  ConfigurationFactory.set("ini", (Json[string] options = null) @safe {
    auto config = new DConfiguration();
    return config.engine(ConfigEngineFactory.create("ini"));
  });

  ConfigurationFactory.set("redis", (Json[string] options = null) @safe {
    auto config = new DConfiguration();
    return config.engine(ConfigEngineFactory.create("redis"));
  });

  ConfigurationFactory.set("rest", (Json[string] options = null) @safe {
    auto config = new DConfiguration();
    return config.engine(ConfigEngineFactory.create("rest"));
  });

  ConfigurationFactory.set("xml", (Json[string] options = null) @safe {
    auto config = new DConfiguration();
    return config.engine(ConfigEngineFactory.create("xml"));
  });

  ConfigurationFactory.set("yaml", (Json[string] options = null) @safe {
    auto config = new DConfiguration();
    return config.engine(ConfigEngineFactory.create("yaml"));
  });
}

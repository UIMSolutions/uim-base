/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.configurations.helpers.set;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

class DConfigurationSet : DSet!IConfiguration {
  mixin(SetThis!("Configuration"));
}

mixin(SetCalls!("Configuration"));

unittest {
  auto set = new DConfigurationSet();
  assert(testSet(new DConfigurationSet, "ConfigurationSet"), "Test of DConfigurationSet failed!");
}
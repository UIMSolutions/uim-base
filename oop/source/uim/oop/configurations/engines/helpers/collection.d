/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.configurations.engines.helpers.collection;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

class DConfigurationCollection : DCollection!IConfiguration {
  mixin(CollectionThis!("Configuration"));
}

mixin(CollectionCalls!("Configuration"));

unittest {
  auto collection = new DConfigurationCollection();
  assert(testCollection(new DConfigurationCollection, "ConfigurationCollection"), "Test of DConfigurationCollection failed!");
}
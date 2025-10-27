/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.configurations.engines.helpers.registry;

import uim.oop;

mixin(Version!"test_uim_oop");
@safe:

class DConfigurationRegistry : DRegistry!DConfiguration {
  mixin(RegistryThis!("Configuration"));
}

mixin(RegistryCalls!("Configuration"));

unittest {
  auto registry = new DConfigurationRegistry();
  assert(registry !is null, "Creation of DConfigurationRegistry failed");

  assert(testRegistry(new DConfigurationRegistry, "DConfigurationRegistry"), "Test of DConfigurationRegistry failed!");
}
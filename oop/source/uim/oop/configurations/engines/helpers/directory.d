/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.configurations.engines.helpers.directories;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

class DConfigurationDirectories : DDirectory!IConfiguration {
  mixin(DirectoriesThis!("Configuration"));
}

mixin(DirectoriesCalls!("Configuration"));

unittest {
  auto directories = new DConfigurationDirectories();
  assert(testDirectories(new DConfigurationDirectories, "ConfigurationDirectories"), "Test of DConfigurationDirectories failed!");
}
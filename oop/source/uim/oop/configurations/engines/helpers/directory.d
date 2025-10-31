/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.configurations.engines.helpers.directory;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

class DConfigEngineDirectories : DDirectory!IConfigEngine {
  mixin(DirectoryThis!("ConfigEngine"));
}

mixin(DirectoryCalls!("ConfigEngine"));

unittest {
  auto directories = new DConfigEngineDirectories();
  assert(testDirectory(new DConfigEngineDirectories, "ConfigEngineDirectories"), "Test of DConfigEngineDirectories failed!");
}
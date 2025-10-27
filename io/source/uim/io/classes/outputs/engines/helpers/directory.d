/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.outputs.engines.helpers.directory;

import uim.io;

mixin(Version!"test_uim_io");
@safe:

class DOutputEngineDirectories : DDirectory!IOutputEngine {
  mixin(DirectoryThis!("OutputEngine"));
}
mixin(DirectoryCalls!("OutputEngine"));

unittest {
  auto directories = OutputEngineDirectories;
  assert(testDirectory(directories, "OutputEngine"), "Test OutputEngineDirectories failed");
}
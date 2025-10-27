/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.inputs.engines.helpers.directory;

import uim.io;

mixin(Version!"test_uim_io");
@safe:

class DInputEngineDirectories : DDirectory!IInputEngine {
  mixin(DirectoryThis!("InputEngine"));
}
mixin(DirectoryCalls!("InputEngine"));

unittest {
  auto directories = InputEngineDirectories;
  assert(testDirectory(directories, "InputEngine"), "Test InputEngineDirectories failed");
}
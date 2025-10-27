/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.inputs.helpers.directory;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

class DInputDirectories : DDirectory!IInput {
  mixin(DirectoryThis!("Input"));
}
mixin(DirectoryCalls!("Input"));

unittest {
  auto directories = InputDirectories;
  assert(testDirectory(directories, "Input"), "Test InputDirectories failed");
}
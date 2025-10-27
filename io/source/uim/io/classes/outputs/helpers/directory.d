/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.outputs.helpers.directory;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

class DOutputDirectories : DDirectory!IOutput {
  mixin(DirectoryThis!("Output"));
}
mixin(DirectoryCalls!("Output"));

unittest {
  auto directories = OutputDirectories;
  assert(testDirectory(directories, "Output"), "Test OutputDirectories failed");

  mixin(TestDirectory!("Output"));
}
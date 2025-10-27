/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.outputs.styles.helpers.directory;

import uim.io;

mixin(Version!"test_uim_io");
@safe:

class DOutputStyleDirectories : DDirectory!IOutputStyle {
  mixin(DirectoryThis!("OutputStyle"));
}
mixin(DirectoryCalls!("OutputStyle"));

unittest {
  auto directories = OutputStyleDirectories;
  assert(testDirectory(directories, "OutputStyle"), "Test OutputStyleDirectories failed");
}
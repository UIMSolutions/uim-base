/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.erroroutputs.helpers.directories;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

class DErrorOutputDirectories : DDirectory!IErrorOutput {
  mixin(DirectoriesThis!("ErrorOutput"));
}
mixin(DirectoriesCalls!("ErrorOutput"));

unittest {
  auto directories = ErrorOutputDirectories;
  assert(testDirectory(directories, "ErrorOutput"), "Test ErrorOutputDirectories failed");
}
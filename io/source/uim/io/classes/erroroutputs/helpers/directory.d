/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.erroroutputs.helpers.directory;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

class DErrorOutputDirectory : DDirectory!IErrorOutput {
  mixin(DirectoryThis!("ErrorOutput"));
}
mixin(DirectoryCalls!("ErrorOutput"));

unittest {
  auto directory = ErrorOutputDirectory;
  assert(testDirectory(directory, "ErrorOutput"), "Test ErrorOutputDirectory failed");
}
/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.outputs.formatters.helpers.directory;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

class DOutputFormatterDirectory : DDirectory!IOutputFormatter {
  mixin(DirectoryThis!("OutputFormatter"));
}
mixin(DirectoryCalls!("OutputFormatter"));

unittest {
  auto directory = OutputFormatterDirectory;
  assert(testDirectory(directory, "OutputFormatter"), "Test OutputFormatterDirectory failed");
}
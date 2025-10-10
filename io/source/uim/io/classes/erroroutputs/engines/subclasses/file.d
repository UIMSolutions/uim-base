/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.classes.erroroutputs.engines.subclasses.file;

import uim.io;

mixin(Version!"test_uim_io");
@safe:

class DFileErrorOutputEngine :  DErrorOutputEngine {
  mixin(ErrorOutputEngineThis!("File"));
}
mixin(ErrorOutputEngineCalls!("File"));

unittest {
  auto output = FileErrorOutput();
  assert(testErrorOutput(output));

  assert(output.name == "FileErrorOutput");
}
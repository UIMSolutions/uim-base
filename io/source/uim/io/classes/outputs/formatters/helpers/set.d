/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.outputs.formatters.helpers.set;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

class DOutputFormatterSet : UIMSet!IOutputFormatter {
  mixin(SetThis!("OutputFormatter"));
}
mixin(SetCalls!("OutputFormatter"));

unittest {
  auto set = OutputFormatterSet;
  assert(testSet(set, "OutputFormatter"), "Test OutputFormatterSet failed");
}
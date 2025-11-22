/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.outputs.formatters.helpers.list;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

class DOutputFormatterList : DList!IOutputFormatter {
  mixin(ListThis!("OutputFormatter"));
}
mixin(ListCalls!("OutputFormatter"));

unittest {
  auto list = OutputFormatterList;
  assert(testList(list, "OutputFormatter"), "Test OutputFormatterList failed");
}
/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.outputs.styles.helpers.list;

import uim.io;

mixin(Version!"test_uim_io");
@safe:

class DOutputStyleList : UIMList!IOutputStyle {
  mixin(ListThis!("OutputStyle"));
}
mixin(ListCalls!("OutputStyle"));

unittest {
  auto list = OutputStyleList;
  assert(testList(list, "OutputStyle"), "Test OutputStyleList failed");
}
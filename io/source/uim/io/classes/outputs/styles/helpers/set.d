/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.outputs.styles.helpers.set;

import uim.io;

mixin(Version!"test_uim_io");
@safe:

class DOutputStyleSet : UIMSet!IOutputStyle {
  mixin(SetThis!("OutputStyle"));
}
mixin(SetCalls!("OutputStyle"));

unittest {
  auto set = OutputStyleSet;
  assert(testSet(set, "OutputStyle"), "Test OutputStyleSet failed");
}
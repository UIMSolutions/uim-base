/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.outputs.helpers.set;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

class DOutputSet : DSet!IOutput {
  mixin(SetThis!("Output"));
}
mixin(SetCalls!("Output"));

unittest {
  auto set = OutputSet;
  assert(testSet(set, "Output"), "Test OutputSet failed");
}
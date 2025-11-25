module uim.io.classes.inputs.helpers.set;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

class DInputSet : UIMSet!IInput {
  mixin(SetThis!("Input"));
}
mixin(SetCalls!("Input"));

unittest {
  auto set = InputSet;
  assert(testSet(set, "Input"), "Test InputSet failed");
}
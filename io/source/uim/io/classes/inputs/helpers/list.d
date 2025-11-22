module uim.io.classes.inputs.helpers.list;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

class DInputList : DList!IInput {
  mixin(ListThis!("Input"));
}
mixin(ListCalls!("Input"));

unittest {
  auto list = InputList;
  assert(testList(list, "Input"), "Test InputList failed");
}
module uim.io.classes.inputs.helpers.collection copy;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

class DInputCollection : DCollection!IInput {
  mixin(CollectionThis!("Input"));
}
mixin(CollectionCalls!("Input"));

unittest {
  auto collection = InputCollection;
  assert(testCollection(collection, "Input"), "Test InputCollection failed");
}
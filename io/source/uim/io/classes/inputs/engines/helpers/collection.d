module uim.io.classes.inputs.engines.helpers.collection;

import uim.io;

mixin(Version!"test_uim_io");
@safe:

class DInputEngineCollection : DCollection!IInputEngine {
  mixin(CollectionThis!("InputEngine"));
}
mixin(CollectionCalls!("InputEngine"));

unittest {
  auto collection = InputEngineCollection;
  assert(testCollection(collection, "InputEngine"), "Test InputEngineCollection failed");
}
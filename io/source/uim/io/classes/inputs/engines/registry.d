module uim.io.classes.inputs.engines.registry;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

class DInputEngineRegistry : DObjectRegistry!DInputEngine {
}

auto InputEngineRegistry() {
  return DInputEngineRegistry.registration;
}
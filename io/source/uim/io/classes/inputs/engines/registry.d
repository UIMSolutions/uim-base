module uim.io.classes.inputs.engines.registry;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

class DInputEngineRegistry : DRegistry!DInputEngine {
}

auto InputEngineRegistry() {
  return DInputEngineRegistry.registration;
}
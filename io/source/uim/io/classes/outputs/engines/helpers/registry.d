module uim.io.classes.outputs.engines.registry;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

class DDOutputEngineRegistry : DObjectRegistry!DOutputEngine {
}

auto OutputEngineRegistry() {
  return DDOutputEngineRegistry.registration;
}
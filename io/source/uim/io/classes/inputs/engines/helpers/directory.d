module uim.io.classes.inputs.engines.helpers.directory;

import uim.io;

mixin(Version!"test_uim_io");
@safe:

class DInputEngineDirectory : DDirectory!IInputEngine {
  mixin(DirectoryThis!("InputEngine"));
}
mixin(DirectoryCalls!("InputEngine"));

unittest {
  auto directory = InputEngineDirectory;
  assert(testDirectory(directory, "InputEngine"), "Test InputEngineDirectory failed");
}
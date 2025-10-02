module uim.io.classes.inputs.engines.subclasses.file;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

// Object wrapper for interacting with stdin
class DFileInput : DInput {
  mixin(InputThis!("File"));
}
mixin(InputCalls!("File"));

unittest {
  auto input = FileInput;
  assert(testInput(input));
}

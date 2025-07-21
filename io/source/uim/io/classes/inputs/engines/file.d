module uim.consoles.classes.inputs.file;

import uim.consoles;
@safe:

mixin(Version!"test_uim_io");

import uim.consoles;
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

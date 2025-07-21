module uim.consoles.classes.inputs.rest;

import uim.consoles;
@safe:

mixin(Version!"test_uim_io");

import uim.consoles;
@safe:


// Object wrapper for interacting with stdin
class DRestInput : DInput {
  mixin(InputThis!("Rest"));
}

mixin(InputCalls!("Rest"));

unittest {
  auto input = RestInput;
  assert(testInput(input));
}

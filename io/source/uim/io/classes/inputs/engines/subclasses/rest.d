module uim.io.classes.inputs.engines.subclasses.rest;

import uim.io;
@safe:

mixin(Version!"test_uim_io");

import uim.io;
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

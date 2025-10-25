module uim.oop.commands.tests.test;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

bool testCommand(ICommand command) {
  assert(command !is null, "In testCommand: command is null");

  return true;
}
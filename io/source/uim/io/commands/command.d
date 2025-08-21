*****************************************************************************************************************/
module uim.io.classes.outputs..commands.command;

mixin(Version!"test_uim_io");

import uim.io;

@safe:

class DOutputEngineCommand : DCommand {
  mixin(CommandThis!("OutputEngine"));
}

mixin(CommandCalls!("OutputEngine"));

unittest {
  assert(testCommand(new DOutputEngineCommand));
}

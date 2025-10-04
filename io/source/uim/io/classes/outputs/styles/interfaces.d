module uim.io.classes.outputs.styles.interfaces;

import uim.io;

mixin(Version!"test_uim_io");
@safe:

// Interface for output styles.
interface IOutputStyle : IObject {

  OutputTypes outputType();
  IOutputStyle outputType(OutputTypes type);

}
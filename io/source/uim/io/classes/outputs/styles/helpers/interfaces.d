module uim.io.classes.outputs.styles.interfaces;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

interface IOutputStyle : IOutputStyle, IObject {

  OutputTypes outputType();
  IOutputStyle outputType(OutputTypes type);

}

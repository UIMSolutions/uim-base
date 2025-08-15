module uim.io.classes.outputs.styles.interfaces;

mixin(Version!"test_uim_io");

import uim.io;

@safe:

class IOutputStyle : IOutputStyle, IObject {
  string render(string text);
}

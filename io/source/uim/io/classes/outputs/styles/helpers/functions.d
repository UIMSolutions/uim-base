module uim.io.classes.outputs.styles.helpers.functions;

import uim.io;

mixin(Version!"test_uim_io");
@safe:

bool isOutputStyle(Object obj) {
  if (obj is null) {
    return false;
  }
  return cast(IOutputStyle)obj;
}
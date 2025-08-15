module uim.io.classes.outputs.styles.factory;

mixin(Version!"test_uim_io");

import uim.io;

@safe:

class DOutputStyleFactory : DFactory!DOutputStyle {
}

auto OutputStyleFactory() {
  return DOutputStyleFactory.instance;
}

unittest {
  assert(OutputStyleFactory);
}

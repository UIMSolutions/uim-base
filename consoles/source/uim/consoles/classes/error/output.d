module uim.consoles.classes.error.output;

mixin(Version!"test_uim_consoles");

import uim.consoles;
@safe:

class DErrorOutput : UIMObject {
  static private DErrorOutput _output;
  static DErrorOutput output() {
    if (_output is null) {
      _output = new DErrorOutput();
    }
    return _output;
  }

  this() {
    name = "ErrorOutput";
  }

  DErrorOutputEngine engine() {
    return new DErrorOutputEngine();
  }
}

auto ErrorOutput() {
  return DErrorOutput.output();
}

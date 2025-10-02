module uim.io.classes.error.output;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

class DErrorOutput : DOutput {
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

  IErrorOutputEngine engine() {
    return new DErrorOutputEngine();
  }

  
}

auto ErrorOutput() {
  return DErrorOutput.output();
}

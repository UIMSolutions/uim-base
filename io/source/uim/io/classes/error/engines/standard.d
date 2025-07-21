/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.classes.error.standard;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

class DStandardErrorOutput:  DErrorOutputEngine {
  mixin(ErrorOutputThis!("Standard"));

  bool write(string message) {
    // Standard error output implementation
    import std.stdio;
    stderr.write(message);
    return true; // Indicate success
  }

  bool writeLn(string message) {
    // Standard error output implementation with newline
    import std.stdio;
    stderr.writeln(message);
    return true; // Indicate success
  }
}
mixin(ErrorOutputCalls!("Standard"));

unittest {
  auto output = StandardErrorOutput();
  assert(testErrorOutput(output));

  assert(output.name == "StandardErrorOutput");
}
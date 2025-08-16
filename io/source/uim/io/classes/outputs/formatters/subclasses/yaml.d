/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.classes.outputs.formatters.subclasses.yaml;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

class DYamlOutputFormatter : DOutputFormatter {
  mixin(OutputFormatterThis!("Yaml"));

  override bool initialize(Json[string] initData = null) {
    if (!super.initialize(initData)) {
      return false;
    }
    return true;
  }
}
mixin(OutputFormatterCalls!("Yaml"));

unittest {
  assert(testOutputFormatter(new DYamlOutputFormatter()), "In DYamlOutputFormatter: Test failed");
}
/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.classes.outputs.formatters.subclasses.json;

import uim.io;

mixin(Version!"test_uim_io");
@safe:

class DJsonOutputFormatter : DOutputFormatter {
  mixin(OutputFormatterThis!("Json"));

  override bool initialize(Json[string] initData = null) {
    if (!super.initialize(initData)) {
      return false;
    }
    return true;
  }
}
mixin(OutputFormatterCalls!("json"));

unittest {
  auto formatter = new DJsonOutputFormatter;
  assert(formatter !is null, "JsonOutputFormatter is null");

  assert(testOutputFormatter(new DJsonOutputFormatter()), "JsonOutputFormatter test failed");
}
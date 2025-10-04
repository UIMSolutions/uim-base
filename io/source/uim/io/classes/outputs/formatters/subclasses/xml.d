/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.classes.outputs.formatters.subclasses.xml;

import uim.io;

mixin(Version!"test_uim_io");
@safe:

class DXmlOutputFormatter : DOutputFormatter {
  mixin(OutputFormatterThis!("Xml"));

  override bool initialize(Json[string] initData = null) {
    if (!super.initialize(initData)) {
      return false;
    }
    return true;
  }
}
mixin(OutputFormatterCalls!("Xml"));

unittest {
  assert(testOutputFormatter(new DXmlOutputFormatter()), "In DXmlOutputFormatter: Test failed");
}
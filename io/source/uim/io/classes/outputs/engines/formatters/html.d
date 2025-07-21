/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.classes.outputs.engines.formatters.html;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

class DHtmlOutputEngineFormatter : DOutputEngineFormatter {
  mixin(OutputEngineFormatterThis!("Html"));

  override bool initialize(Json[string] initData = null) {
    if (!super.initialize(initData)) {
      return false;
    }
    return true;
  }
}
mixin(OutputEngineFormatterCalls!("Html"));
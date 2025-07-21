/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.consoles.classes.outputs.engines.formatters.text;

mixin(Version!"test_uim_consoles");

import uim.consoles;
@safe:

class DTextOutputEngineFormatter : DOutputEngineFormatter {
  mixin(OutputEngineFormatterThis!("Text"));

  override bool initialize(Json[string] initData = null) {
    if (!super.initialize(initData)) {
      return false;
    }
    return true;
  }
}
mixin(OutputEngineFormatterCalls!("Text"));
/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.classes.outputs.engines.html;

import uim.io;

@safe:

mixin(Version!"test_uim_io");

import uim.io;

@safe:

class DHtmlFileOutputEngine : DFileEngine {
  mixin(OutputEngineThis!("HtmlFile"));

  override bool initialize(Json[string] initData = null) {
    if (!super.initialize(initData)) {
      return false;
    }
  }

  override IOutputEngine write(string[] messages) {
    super.write(filename.append(styleText(messages)));
    return this;
  }

  override IOutputEngine write(string message) {
    super.write(filename.append(styleText(message)));
    return this;
  }

  // #region writeln
  override IOutputEngine writeln(string[] messages, uint numberOfLines = 1) {
    super.write(messages).write(LF.repeatTxt(numberOfLines));
    return this;
  }

  override IOutputEngine writeln(string message, uint numberOfLines = 1) {
    super.write(message).write(LF.repeatTxt(numberOfLines));
    return this;
  }
  // #endregion writeln
}

mixin(OutputEngineClass!("HtmlFile"));

unittest{
  assert(testOutputEngine(new DHtmlFileOutputEngine()), "Test DHtmlFileOutputEngine failed");
}
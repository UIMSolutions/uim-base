/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.classes.outputs.engines.subclasses.memory;

import uim.io;

mixin(Version!"test_uim_io");
@safe:

class DMemoryOutputEngine : DOutputEngine {
  mixin(OutputEngineThis!"Memory");

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

mixin(OutputEngineCalls!"Memory");

unittest {
  auto engine = new DMemoryOutputEngine();
  assert(engine !is null, "DMemoryOutputEngine is null");

  assert(testOutputEngine(engine, "MemoryOutputEngine"), "Test DMemoryOutputEngine failed");  
}
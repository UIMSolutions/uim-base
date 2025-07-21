/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.consoles.classes.outputs.output;

mixin(Version!"test_uim_io");

import uim.consoles;

@safe:

class DOutput : UIMObject, IOutput {
  protected static DOutput _output;
  static DOutput output() {
    if (_output is null) {
      _output = new DOutput;
    }

    return _output;
  }
  // Default constructor
  this() {
    super();
  }

  // Returns the name of the output engine
  override string name() const {
    return "Output";
  }

  protected IOutputEngine[string] _engines;
  // Returns the list of output engines
  override IOutputEngine[string] engines() {
    if (_engines.length == 0) {
      _engines = OutputEngineCollection().engines();

      if (_engines.length == 0) {
        throw new UIMException("No output engines configured.");
      }

      // Sort the engines by name
      _engines = _engines.sort!((a, b) => a.name < b.name);
    }
    return _engines;
  }

  // Returns the default output engine
  override IOutputEngine defaultEngine() {
    return OutputEngineFactory("default");
  }

  DOutput write(uint numberOfLines = 1) {
    return engines.byKeys.all!(name => !writeToEngine(name, numberOfLines).isNull) ? this : null;
  }

  IOutputEngine engine(string name) {
    auto engine = (name in engines) ? engines[name] : null;
    if (engine.isNull) {
      // TODO Errormessage
      return null; 
    }
  }

  DOutput writeToEngine(string name, uint numberOfLines = 1) {
    if (auto engine = engine(name)) {
      return !engine.write(numberOfLines).isNull ? this : null;
    }
    return null; 
  }

  DOutput write(string[] messages, uint numberOfLines = 1) {
    return engines.byKeys.all!(name => !writeToEngine(name, messages, numberOfLines).isNull) ? this : null;
  }

  DOutput writeToEngine(string name, string[] messages, uint numberOfLines = 1) {
    if (auto engine = engine(name)) {
      return !engine.write(messages, numberOfLines).isNull ? this : null;
    }
    return null; 
  }

  DOutput write(string message, uint numberOfLines = 1) {
    return engines.byKeys.all!(name => !writeToEngine(name, message, numberOfLines).isNull) ? this : null;
  }

  DOutput writeToEngine(string name, string message, uint numberOfLines = 1) {
    if (auto engine = engine(message, name)) {
      return !engine.write(numberOfLines).isNull ? this : null;
    }
    return null; 
  }
}

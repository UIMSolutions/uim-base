/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.classes.outputs.output;

mixin(Version!"test_uim_io");

import uim.io;

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

  // #region engines
  // Collection of output engines
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

  IOutputEngine engine(string name) {
    auto engine = (name in engines) ? engines[name] : null;
    if (engine.isNull) {
      // TODO Errormessage
      return null;
    }
  }

  IOutput engine(string name, IOutputEngine engine) {
    if (!name.isEmpty) {
      _engines[name] = engine;
    }
    return this;
  }
  // #endregion engines

  // #region write
  DOutput write(uint numberOfLines = 1) {
    return engines.byKeys.all!(name => !writeToEngine(name, numberOfLines).isNull) ? this : null;
  }

  DOutput write(string[] messages, uint numberOfLines = 1) {
    return engines.byKeys.all!(name => !writeToEngine(name, messages, numberOfLines).isNull) ? this
      : null;
  }

  DOutput write(string message, uint numberOfLines = 1) {
    return engines.byKeys.all!(name => !writeToEngine(name, message, numberOfLines).isNull) ? this
      : null;
  }

  // #endregion write

  // #region writeToEngine
  DOutput writeToEngine(string name, uint numberOfLines = 1) {
    if (auto engine = engine(name)) {
      return !engine.write(numberOfLines).isNull ? this : null;
    }
    return null;
  }

  DOutput writeToEngine(string name, string[] messages, uint numberOfLines = 1) {
    if (auto engine = engine(name)) {
      return !engine.write(messages, numberOfLines).isNull ? this : null;
    }
    return null;
  }

  DOutput writeToEngine(string name, string message, uint numberOfLines = 1) {
    if (auto engine = engine(message, name)) {
      return !engine.write(numberOfLines).isNull ? this : null;
    }
    return null;
  }
  // #endregion writeToEngine

  // #region Output methods
  // Convenience method for out() that wraps message between <info> ta
  int info(string[] messages, int newLinesToAppend = 1, int outputLevel = NORMAL) {
    string messageType = "info";
    auto outputMessages = wrapMessageWithType(messageType, messages);

    // return _writeln(outputMessages, newLinesToAppend, outputLevel);
    return 0;
  }

  // Convenience method for out() that wraps message between <comment> tag
  int comment(string[] outputMessages, int newLinesToAppendToAppend = 1, int outputLevel = NORMAL) {
    auto message = wrapMessageWithType("comment", outputMessages);
    // return _writeln(message, newLinesToAppend, outputLevel); */
    return 0;
  }

  // Convenience method for writeErrorMessages() that wraps message between <warning> tag
  int warning(string[] outputMessages, int newLinesToAppend = 1) {
    auto message = wrapMessageWithType("warning", outputMessages);

    // return _writeErrorMessages(message, newLinesToAppend); */
    return 0;
  }

  /**
     * Convenience method for writeErrorMessages() that wraps message between <error> tag
     * Params:
     * string[]|string message A string or an array of strings to output
     */
  int error(string[] message, int newLinesToAppend = 1) {
    string messageType = "error";
    message = wrapMessageWithType(messageType, message);

    // return _writeErrorMessages(message, newLinesToAppend);
    return 0;
  }

  // Convenience method for out() that wraps message between <success> tag
  int success(string[] message, int newLinesToAppend = 1, int outputLevel = NORMAL) {
    string messageType = "success";
    message = wrapMessageWithType(messageType, message);

    // return _writeln(message, newLinesToAppend, outputLevel);
    return 0;
  }
  // #endregion Output methods
}

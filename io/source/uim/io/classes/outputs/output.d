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

  // Returns the name of the output
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

  unittest {
    // Mock IOutputEngine implementation for testing
    class MockOutputEngine : IOutputEngine {
      string _name;
      this(string name) {
        _name = name;
      }

      override string name() const {
        return _name;
      }

      override DOutput write(uint numberOfLines) {
        return null;
      }

      override DOutput write(string[] messages, uint numberOfLines) {
        return null;
      }

      override DOutput write(string message, uint numberOfLines) {
        return null;
      }
    }

    // Mock OutputEngineCollection
    class MockOutputEngineCollection {
      IOutputEngine[string] _engines;
      this() {
        _engines["engineA"] = new MockOutputEngine("engineA");
        _engines["engineB"] = new MockOutputEngine("engineB");
      }

      IOutputEngine[string] engines() {
        return _engines;
      }
    }

    // Mock OutputEngineFactory
    IOutputEngine MockOutputEngineFactory(string name) {
      return new MockOutputEngine(name);
    }

    // Patch DOutput for testing
    class TestDOutput : DOutput {
      override IOutputEngine[string] engines() {
        if (_engines.length == 0) {
          _engines = MockOutputEngineCollection().engines();
        }
        return _engines;
      }

      override IOutputEngine defaultEngine() {
        return MockOutputEngineFactory("default");
      }
    }

    auto output = new TestDOutput();

    // Test: engines() returns engines and sorts them
    auto engines = output.engines();
    assert(engines.length == 2);
    assert("engineA" in engines);
    assert("engineB" in engines);

    // Test: defaultEngine() returns a mock engine
    auto defEngine = output.defaultEngine();
    assert(defEngine !is null);
    assert(defEngine.name == "default");

    // Test: engine(string name) returns correct engine
    auto engineA = output.engine("engineA");
    assert(engineA !is null);
    assert(engineA.name == "engineA");

    // Test: engine(string name) returns null for unknown engine
    auto engineX = output.engine("engineX");
    assert(engineX is null);

    // Test: engine(string name, IOutputEngine engine) sets engine
    auto customEngine = new MockOutputEngine("custom");
    output.engine("custom", customEngine);
    assert(output.engines()["custom"] is customEngine);
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

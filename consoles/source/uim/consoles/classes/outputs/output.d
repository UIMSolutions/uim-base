/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.consoles.classes.outputs.output;

mixin(Version!"test_uim_consoles");

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

  protected DOutputEngine[string] _engines;
  // Returns the list of output engines
  override DOutputEngine[string] engines() {
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
}

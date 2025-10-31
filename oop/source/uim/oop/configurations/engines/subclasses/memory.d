/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.configurations.engines.subclasses.memory;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

class DMemoryConfigEngine : DConfigEngine, IConfigEngine {
  mixin(ConfigEngineThis!("Memory"));

    protected Json[string] _entries;

  // #region keys
  override string[] keys() {
    return _entries.keys;
  }
  // #endregion keys

  // #region values
  override Json[] values() {
    return _entries.values;
  }
  // #endregion values
  
  // #region has
    override bool hasKey(string key) {
      return _entries.hasKey(key);
    }
      
    override bool hasValue(Json value) {
      return _entries.values.any!(v => v == value);
    }
  // #endregion has

  // #region get
    override Json value(string key) {
      if (key.length == 0) {
        return Json(null);
      }

      return key in _entries ? _entries[key] : Json(null);
    }

    unittest {
      auto config = MemoryConfigEngine;
      // TODO
    }
  // #endregion get

  // #region set
    override bool setKey(string key, Json value) {
      if (key.length == 0) {
        return this;
      }

      _entries[key] = value;
      return true;
    }

    unittest{
      auto config = MemoryConfigEngine;

      // TODO 
    }
  // #endregion set

  // #endregion remove
    override bool removeKey(string key) {
      if (key.length == 0) {
        return this;
      }

      _entries.remove(key);
      return true;
    }

    unittest {
      auto config = MemoryConfigEngine;
      // TODO
    }
  // #endregion remove

  // #region clone
  bool clone() {
    return MemoryConfigEngine
      .entries(entries());
  }
  // #endregion clone
}

mixin(ConfigEngineCalls!("Memory"));

unittest {
  auto configuration = MemoryConfigEngine;
  assert(testConfiguration(MemoryConfigEngine, "Memory"), "MemoryConfigEngine test failed") ;
}

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

  // #region entries
  protected Json[string] _entries;
  override Json[string] entries() {
    return _entries.dup;
  }
  override void entries(Json[string] entries) {
    _entries = entries.dup;
  }
  // #endregion entries

  // #region paths
  override string[][] paths() {
    return _entries.keys.map!(key => key.split(_separator)).array;
  }
  // #endregion paths

  // #region keys
  override string[] keys() {
    return _entries.keys;
  }

  // #region has
  override bool hasKey(string key) {
    return _entries.hasKey(key);
  }
  // #endregion has
  // #endregion keys

  // #region values
  // #region get
  override Json[] values() {
    return _entries.values;
  }

  override Json[] values(string[] keys) {
    return keys.map!(key => value(key)).array;
  }

  override Json value(string[] path) {
    return value(path.toKey(_separator));
  }

  override Json value(string key) {
    if (key.length == 0) {
      return Json(null);
    }

    return key in _entries ? _entries[key] : Json(null);
  }
  // #endregion get

  // #region has
  override bool hasValue(Json value) {
    return _entries.values.any!(v => v == value);
  }
  // #endregion has
  // #endregion values

  // #region set
  override bool setKey(string key, Json value) {
    if (key.length == 0) {
      return false;
    }

    _entries[key] = value;
    return true;
  }

  unittest {
    auto config = MemoryConfigEngine;

    // TODO 
  }
  // #endregion set

  // #region removeKey
  override bool removeKey(string key) {
    if (key.length == 0) {
      return false;
    }

    if (!hasKey(key)) {
      return false;
    }

    _entries.remove(key);
    return hasKey(key);
  }
  // #endregion removeKey

  // #region clone
  IConfigEngine clone() {
    auto engine = new DMemoryConfigEngine();
    engine.entries(entries());
    return engine;
  }
  // #endregion clone
}

mixin(ConfigEngineCalls!("Memory"));

unittest {
  auto configuration = MemoryConfigEngine;
  assert(testConfiguration(MemoryConfigEngine, "Memory"), "MemoryConfigEngine test failed");
}

/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.caches.classes.engines.registryx;

mixin(Version!"test_uim_caches");

import uim.caches;

@safe:

class DCacheEngineRegistry : DRegistry!ICacheEngine {
}

mixin(RegistryCalls!("DCacheEngine", "cacheEngine", "ICacheEngine"));

unittest {
  // Create a dummy ICacheEngine implementation for testing
  class DummyCacheEngine : ICacheEngine {
    override void clear() {
    }

    override void put(string key, Variant value) {
    }

    override Variant get(string key) {
      return Variant.init;
    }

    override bool contains(string key) {
      return false;
    }
  }

  auto registry = new DCacheEngineRegistry();

  // Test registration
  auto engine = new DummyCacheEngine();
  registry.register("dummy", engine);

  // Test retrieval
  auto retrieved = registry.get("dummy");
  assert(retrieved is engine, "Registry should return the registered engine instance");

  // Test contains
  assert(registry.contains("dummy"), "Registry should contain the registered engine");

  // Test unregister
  registry.unregister("dummy");
  assert(!registry.contains("dummy"), "Registry should not contain the engine after unregistering");

  // Test get on missing key
  assertThrown!Exception(registry.get("missing"), "Registry.get should throw on missing key");
}

/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.parsers.registry;

mixin(Version!"test_uim_oop");

import uim.oop;

@safe:

class DParserRegistry : DRegistry!IParser {
  mixin(RegistryThis!("Parser"));
}

mixin(RegistryCalls!("Parser"));

unittest {
  /* auto registry = new DParserRegistry();

  // Test: Register a parser
  auto parser = new DummyParser();
  registry.register("dummy", parser);

  // Test: Retrieve the parser
  auto retrieved = registry.get("dummy");
  assert(retrieved is parser, "Retrieved parser should be the same as registered parser");

  // Test: Registry contains the parser
  assert(registry.contains("dummy"), "Registry should contain 'dummy' parser");

  // Test: Unregister the parser
  registry.unregister("dummy");
  assert(!registry.contains("dummy"), "Registry should not contain 'dummy' after unregister"); */
}

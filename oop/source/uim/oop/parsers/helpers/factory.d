/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.parsers.helpers.factory;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

class DParserFactory : DFactory!IParser {
  mixin(FactoryThis!("Parser"));
}
mixin(FactoryCalls!("Parser"));

unittest {
  auto factory = new DParserFactory();
  assert(testFactory(factory, "Parser"), "Test ParserFactory failed");
}  
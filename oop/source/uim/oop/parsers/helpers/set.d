/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.parsers.helpers.set;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

class DParserSet : UIMSet!IParser {
  mixin(SetThis!("Parser"));
}
mixin(SetCalls!("Parser"));

unittest {
  auto set = ParserSet;
  assert(testSet(set, "Parser"), "Test ParserSet failed");
}
/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.parsers.helpers.list;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

class DParserList : DList!IParser {
  mixin(ListThis!("Parser"));
}
mixin(ListCalls!("Parser"));

unittest {
  auto list = ParserList;
  assert(testList(list, "Parser"), "Test ParserList failed");
}
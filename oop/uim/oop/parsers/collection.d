/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.parsers.collection;

import uim.oop;
@safe:

class DParserCollection : DCollection!DParser {   
}

auto ParserCollection() {
    return new DParserCollection;
}

unittest {
  assert(ParserCollection);

  auto collection = ParserCollection;
}
/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.parsers.collection;

mixin(Version!"test_uim_oop");

import uim.oop;
@safe:

/** 
  * Parser for collections of type `IParser`.
  *
  * This parser provides methods to parse collections of `IParser` objects.
  */
class DParserCollection : DCollection!IParser {   
}
/// 
unittest {
  // Test with empty collection
  auto emptyParser = new DParserCollection();
  assert(emptyParser.isEmpty);

  // Test with single parser
  auto singleParser = new DParserCollection();
  singleParser.add(new Parser("Single"));
  assert(!singleParser.isEmpty);
  assert(singleParser.size == 1);
  assert(singleParser.first.name == "Single");

  // Test with multiple parsers
  auto multiParser = new DParserCollection();
  multiParser.add(new Parser("First"));
  multiParser.add(new Parser("Second"));
  assert(multiParser.size == 2);
  assert(multiParser.last.name == "Second");
}

mixin(CollectionCalls!("Parser"));

unittest {
  // Test that DParserCollection can be instantiated
  auto collection = new DParserCollection();
  assert(collection !is null, "DParserCollection instance should not be null");
}
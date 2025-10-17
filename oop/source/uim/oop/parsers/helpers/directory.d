/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.parsers.helpers.directory;

mixin(Version!"test_uim_oop");

import uim.oop;

@safe:

/** 
  * Parser for directorys of type `IParser`.
  *
  * This parser provides methods to parse directorys of `IParser` objects.
  */
class DParserDirectory : DDirectory!IParser {
  mixin(DirectoryThis!("Parser"));
}
/// 
unittest {
  // Test with empty directory
  auto emptyParser = new DParserDirectory();
  assert(emptyParser.isEmpty);

  // Test with single parser
  auto singleParser = new DParserDirectory();
  singleParser.add(new Parser("Single"));
  assert(!singleParser.isEmpty);
  assert(singleParser.size == 1);
  assert(singleParser.first.name == "Single");

  // Test with multiple parsers
  auto multiParser = new DParserDirectory();
  multiParser.add(new Parser("First"));
  multiParser.add(new Parser("Second"));
  assert(multiParser.size == 2);
  assert(multiParser.last.name == "Second");
}

mixin(DirectoryCalls!("Parser"));

unittest {
  // Test that DParserDirectory can be instantiated
  auto directory = new DParserDirectory();
  assert(directory !is null, "DParserDirectory instance should not be null");
}

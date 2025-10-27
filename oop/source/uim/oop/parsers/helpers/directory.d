/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.parsers.helpers.directory;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

class DParserDirectories : DDirectory!IParser {
  mixin(DirectoryThis!("Parser"));
}
mixin(DirectoryCalls!("Parser"));

unittest {
  auto directories = new DParserDirectories();
  assert(testDirectory(directories, "Parser"), "Test ParserDirectories failed");
}
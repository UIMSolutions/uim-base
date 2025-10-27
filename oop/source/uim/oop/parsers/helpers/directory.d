/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.parsers.helpers.directories;

mixin(Version!"test_uim_oop");

import uim.oop;

@safe:

class DParserDirectories : DDirectory!IParser {
  mixin(DirectoriesThis!("Parser"));
}
mixin(DirectoriesCalls!("Parser"));

unittest {
  auto directories = new DParserDirectories();
  assert(testDirectory(directories, "Parser"), "Test ParserDirectories failed");
}
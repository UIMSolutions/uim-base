/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.consoles.helpers.directory;

import uim.io;
@safe:

mixin(Version!"test_uim_io");

import uim.io;
@safe:

class DConsoleDirectory : DDirectory!IConsole {
  mixin(DirectoryThis!("Console"));
}
mixin(DirectoryCalls!("Console"));

unittest {
  auto directory = ConsoleDirectory;
  assert(testDirectory(directory, "Console"), "Test ConsoleDirectory failed");
}
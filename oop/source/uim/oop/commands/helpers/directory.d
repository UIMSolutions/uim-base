/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.commands.helpers.directories;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

class DCommandDirectory : DDirectory!ICommand {
  mixin(DirectoriesThis!("Command"));
}

mixin(DirectoriesCalls!("Command"));

unittest {
  auto directories = new DCommandDirectory();
  assert(testDirectories(new DCommandDirectory, "CommandDirectory"), "Test of DCommandDirectory failed!");
}
/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.commands.helpers.set;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

class DCommandSet : DSet!ICommand {
  mixin(SetThis!("Command"));
}

mixin(SetCalls!("Command"));

unittest {
  auto set = new DCommandSet();
  assert(testSet(set, "CommandSet"), "Test of DCommandSet failed!");
}
/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.commands.helpers.factory;

import uim.oop;

mixin(Version!"test_uim_oop");
@safe:

class DCommandFactory : DFactory!ICommand {
  mixin(FactoryThis!("Command"));
}
mixin(FactoryCalls!("Command"));

unittest {
  // Test that DCommandFactory can be instantiated
  auto factory = new DCommandFactory();
  assert(factory !is null, "DCommandFactory instance should not be null");

}

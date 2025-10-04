/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
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

  // Test that DCommandFactory creates ICommand objects
  auto cmd = factory.create();
  assert(cmd !is null, "create() should return a non-null ICommand");
  static assert(is(typeof(cmd) : ICommand), "create() should return an ICommand");

  // Test that createByName works if available
  static if (__traits(hasMember, factory, "createByName")) {
    auto namedCmd = factory.createByName("DCommand");
    assert(namedCmd !is null, "createByName should return a non-null ICommand for valid name");
    static assert(is(typeof(namedCmd) : ICommand), "createByName should return an ICommand");
  }
}

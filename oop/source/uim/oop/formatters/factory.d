/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.formatters.factory;

mixin(Version!"test_uim_oop");

import uim.oop;

@safe:

class DFormatterFactory : DFactory!IFormatter {
}

mixin(FactoryCalls!("DFormatter", "formatter", "IFormatter"));

unittest {
  // Test that DFormatterFactory can be instantiated
  auto factory = new DFormatterFactory();
  assert(factory !is null, "DFormatterFactory instance should not be null");

  // Test that DFormatterFactory is derived from DFactory!IFormatter and IFactory!IFormatter
  static assert(is(DFormatterFactory : DFactory!IFormatter), "DFormatterFactory should derive from DFactory!IFormatter");
  static assert(is(DFormatterFactory : IFactory!IFormatter), "DFormatterFactory should implement IFactory!IFormatter");

  // Test that factory can create an IFormatter instance (if create method exists)
  static if (__traits(hasMember, DFormatterFactory, "create")) {
    auto formatter = factory.create();
    assert(formatter !is null, "Factory should create a non-null IFormatter instance");
    static assert(is(typeof(formatter) : IFormatter), "Created object should implement IFormatter");
  } else {
    writeln("DFormatterFactory does not have a create() method to test.");
  }
}

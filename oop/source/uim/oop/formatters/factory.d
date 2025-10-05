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
  mixin(FactoryThis!("Formatter"));
}
mixin(FactoryCalls!("Formatter"));

unittest {
  // Test that DFormatterFactory can be instantiated
  auto factory = new DFormatterFactory();
  assert(factory !is null, "DFormatterFactory instance should not be null");

}

/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.validators.factory;

mixin(Version!"test_uim_oop");

import uim.oop;
@safe:

class DValidatorFactory : DFactory!IValidator {
    mixin(FactoryThis!("Validator"));
}
mixin(FactoryCalls!("Validator"));

unittest {
  auto factory = new DValidatorFactory();
  assert(factory !is null, "ValidatorFactory is null");

  assert(testFactory(factory, "Validator"), "Test ValidatorFactory failed");
}



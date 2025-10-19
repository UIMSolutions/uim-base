/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.validators.tests.mixins;

mixin(Version!"test_uim_oop");

import uim.oop;
@safe:

template ValidatorTests(T : IValidator, string typeName) {
  unittest {
    auto validator = T.init;
    assert(testValidator(validator, typeName), "Test of " ~ typeName ~ " validator failed!");
  }
}
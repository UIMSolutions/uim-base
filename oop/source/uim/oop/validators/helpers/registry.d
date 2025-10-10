/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.validators.helpers.registry;

mixin(Version!"test_uim_oop");

import uim.oop;

@safe:

class DValidatorRegistry : DRegistry!IValidator {
  mixin(RegistryThis!("Validator"));
}

mixin(RegistryCalls!("Validator"));

unittest {
  // Test that ValidatorRegistry returns a singleton instance
  auto reg1 = ValidatorRegistry();
  auto reg2 = ValidatorRegistry();
  assert(reg1 is reg2, "ValidatorRegistry should return the same instance");

  // Test that registry can register and retrieve a validator
  class TestValidator : DUIMValidator {
    override bool validate(DUIMObject obj) {
      return true;
    }
  }

  auto validator = new TestValidator();
  reg1.register("test", validator);

  auto retrieved = reg1.get("test");
  assert(cast(TestValidator)retrieved is validator, "Should retrieve the registered validator");

  // Test that get returns null for unknown key
  assert(reg1.get("unknown") is null, "Should return null for unknown key");
}

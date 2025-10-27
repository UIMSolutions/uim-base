/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.validators.helpers.registry;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

class DValidatorRegistry : DRegistry!IValidator {
  mixin(RegistryThis!("Validator"));
}

mixin(RegistryCalls!("Validator"));

unittest {
  // Test that ValidatorRegistry returns a singleton instance
  auto registry1 = ValidatorRegistry();
  auto registry2 = ValidatorRegistry();
  assert(registry1 is registry2, "ValidatorRegistry should return the same instance");

  // Test that registry can register and retrieve a validator
  class TestValidator : DUIMValidator {
    override bool validate(DUIMObject obj) {
      return true;
    }
  }

  auto validator = new TestValidator();
  registry1.register("test", validator);

  auto retrieved = registry1.get("test");
  assert(cast(TestValidator)retrieved is validator, "Should retrieve the registered validator");

  // Test that get returns null for unknown key
  assert(registry1.get("unknown") is null, "Should return null for unknown key");
}

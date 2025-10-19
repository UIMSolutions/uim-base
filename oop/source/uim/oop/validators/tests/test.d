/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.validators.tests.test;

mixin(Version!"test_uim_oop");

import uim.oop;
@safe:

bool testValidator(IValidator validator, string typeName) {
  assert(validator !is null, "Validator should not be null");
  assert(validator.name == typeName, "Validator type name does not match");
  
  return true;
}

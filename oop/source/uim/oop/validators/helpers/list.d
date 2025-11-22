/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.validators.helpers.list;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

class DValidatorList : DList!IValidator {
  mixin(ListThis!("Validator"));
}
mixin(ListCalls!("Validator"));

unittest {
  auto list = ValidatorList;
  assert(testList(list, "Validator"), "Test ValidatorList failed");
}
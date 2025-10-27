/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.validators.helpers.collection;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

class DValidatorCollection : DCollection!IValidator {
  mixin(CollectionThis!("Validator"));
}
mixin(CollectionCalls!("Validator"));

unittest {
  auto collection = ValidatorCollection;
  assert(testCollection(collection, "Validator"), "Test ValidatorCollection failed");
}
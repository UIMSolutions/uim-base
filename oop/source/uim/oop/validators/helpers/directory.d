/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.validators.helpers.directory;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

class DValidatorDirectories : DDirectory!IValidator {  
    mixin(DirectoryThis!("Validator")); 
}
mixin(DirectoryCalls!("Validator"));

unittest {
  auto directories = ValidatorDirectories;
  assert(testDirectory(directories, "Validator"), "Test ValidatorDirectories failed");
}
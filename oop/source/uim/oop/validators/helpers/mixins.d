/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.validators.helpers.mixins;

mixin(Version!"test_uim_oop");

import uim.oop;
@safe:

string validatorThis(string name = null) {
    string fullName = name ~ "Validator";
    return objThis(fullName);
}

template ValidatorThis(string name = null) {
    const char[] ValidatorThis = validatorThis(name);
}

string validatorCalls(string name) {
    string fullName = name ~ "Validator";
    return objCalls(fullName);
}

template ValidatorCalls(string name) {
    const char[] ValidatorCalls = validatorCalls(name);
}
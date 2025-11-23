/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.validators.helpers.mixins;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

string validatorThis(string name = null, bool overrideMemberNames = true) {
    string fullName = name ~ "Validator";
    return objThis(fullName, overrideMemberNames);
}

template ValidatorThis(string name = null, bool overrideMemberNames = true) {
    const char[] ValidatorThis = validatorThis(name, overrideMemberNames);
}

string validatorCalls(string name) {
    string fullName = name ~ "Validator";
    return objCalls(fullName);
}

template ValidatorCalls(string name) {
    const char[] ValidatorCalls = validatorCalls(name);
}
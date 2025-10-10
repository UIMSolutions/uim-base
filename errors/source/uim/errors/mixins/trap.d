/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.errors.mixins.trap;

import uim.errors;

@safe:
string errorTrapThis(string name = null) {
    string fullName = name ~ "ErrorTrap";
    return objThis(fullName);
}

template ErrorTrapThis(string name = null) {
    const char[] ErrorTrapThis = errorTrapThis(name);
}

string errorTrapCalls(string name) {
    string fullName = name ~ "ErrorTrap";
    return objCalls(fullName);
}

template ErrorTrapCalls(string name) {
    const char[] ErrorTrapCalls = errorTrapCalls(name);
}

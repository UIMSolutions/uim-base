/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.exceptions.mixins.trap;

import uim.exceptions;

@safe:
string exceptionTrapThis(string name = null) {
    string fullName = name ~ "ExceptionTrap";
    return objThis(fullName);
}

template ExceptionTrapThis(string name = null) {
    const char[] ExceptionTrapThis = exceptionTrapThis(name);
}

string exceptionTrapCalls(string name) {
    string fullName = name ~ "ExceptionTrap";
    return objCalls(fullName);
}

template ExceptionTrapCalls(string name) {
    const char[] ExceptionTrapCalls = exceptionTrapCalls(name);
}

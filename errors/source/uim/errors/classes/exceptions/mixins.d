/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.errors.classes.exceptions.mixins;

mixin(Version!("test_uim_errors"));

import uim.errors;
@safe:

@safe:
string exceptionThis(string name = null) {
    string fullName = name ~ "Exception";
    return objThis(fullName);
}

template ExceptionThis(string name = null) {
    const char[] ExceptionThis = exceptionThis(name);
}

string exceptionCalls(string name) {
    string fullName = name ~ "Exception";
    return objCalls(fullName);
}

template ExceptionCalls(string name) {
    const char[] ExceptionCalls = exceptionCalls(name);
}

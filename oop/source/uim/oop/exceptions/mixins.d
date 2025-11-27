/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.exceptions.mixins;

import uim.oop;
mixin(Version!("test_uim_oop"));
@safe:

@safe:
string exceptionThis(string name = null, bool overrideMemberNames = true) {
    string fullName = name ~ "Exception";
    return objThis(fullName, overrideMemberNames);
}

template ExceptionThis(string name = null, bool overrideMemberNames = true) {
    const char[] ExceptionThis = exceptionThis(name, overrideMemberNames);
}

string exceptionCalls(string name) {
    string fullName = name ~ "Exception";
    return objCalls(fullName);
}

template ExceptionCalls(string name) {
    const char[] ExceptionCalls = exceptionCalls(name);
}

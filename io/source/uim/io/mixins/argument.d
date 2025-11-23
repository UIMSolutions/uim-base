/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.mixins.argument;

import uim.io;

@safe:
string argumentThis(string name = null, bool overrideMemberNames = true) {
    string fullName = name ~ "Argument";
    return objThis(fullName, overrideMemberNames);
}

template ArgumentThis(string name = null, bool overrideMemberNames = true) {
    const char[] ArgumentThis = argumentThis(name, overrideMemberNames);
}

string argumentCalls(string name) {
    string fullName = name ~ "Argument";
    return objCalls(fullName);
}

template ArgumentCalls(string name) {
    const char[] ArgumentCalls = argumentCalls(name);
}

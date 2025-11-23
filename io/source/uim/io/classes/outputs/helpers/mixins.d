/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.outputs.helpers.mixins;

import uim.io;

mixin(Version!"test_uim_io");
@safe:

string outputThis(string name = null, bool overrideMemberNames = true) {
    string fullName = name ~ "Output";
    return objThis(fullName, overrideMemberNames);
}

template OutputThis(string name = null, bool overrideMemberNames = true) {
    const char[] OutputThis = outputThis(name, overrideMemberNames);
}

string outputCalls(string name) {
    string fullName = name ~ "Output";
    return objCalls(fullName);
}

template OutputCalls(string name) {
    const char[] OutputCalls = outputCalls(name);
}

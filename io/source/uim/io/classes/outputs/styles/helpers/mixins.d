/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.outputs.styles.helpers.mixins;

import uim.io;

mixin(Version!"test_uim_io");
@safe:

string outputstyleThis(string name = null, bool overrideMemberNames = true) {
    string fullName = name ~ "OutputStyle";
    return objThis(fullName, overrideMemberNames);
}

template OutputStyleThis(string name = null, bool overrideMemberNames = true) {
    const char[] OutputStyleThis = outputstyleThis(name, overrideMemberNames);
}

string outputstyleCalls(string name) {
    string fullName = name ~ "OutputStyle";
    return objCalls(fullName);
}

template OutputStyleCalls(string name) {
    const char[] OutputStyleCalls = outputstyleCalls(name);
}

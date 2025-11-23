/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.outputs.formatters.helpers.mixins;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

string outputFormatterThis(string name = null, bool overrideMemberNames = true) {
    string fullName = name ~ "OutputFormatter";
    return objThis(fullName, overrideMemberNames);
}

template OutputFormatterThis(string name = null, bool overrideMemberNames = true) {
    const char[] OutputFormatterThis = outputFormatterThis(name, overrideMemberNames);
}

string outputFormatterCalls(string name) {
    string fullName = name ~ "OutputFormatter";
    return objCalls(fullName);
}

template OutputFormatterCalls(string name) {
    const char[] OutputFormatterCalls = outputFormatterCalls(name);
}

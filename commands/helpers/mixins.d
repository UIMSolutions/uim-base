/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.commands.helpers.mixins;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

string commandThis(string name = null, bool overrideMemberNames = true) {
    string fullName = name ~ "Command";
    return objThis(fullName, overrideMemberNames);
}

template CommandThis(string name = null, bool overrideMemberNames = true) {
    const char[] CommandThis = commandThis(name, overrideMemberNames);
}

string commandCalls(string name) {
    string fullName = name ~ "Command";
    return objCalls(fullName);
}

template CommandCalls(string name) {
    const char[] CommandCalls = commandCalls(name);
}

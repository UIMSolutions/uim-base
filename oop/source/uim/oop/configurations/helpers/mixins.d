/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.configurations.helpers.mixins;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

string configurationThis(string name = null, bool overrideMemberNames = true) {
    string fullName = name ~ "Configuration";
    return objThis(fullName, overrideMemberNames);
}

template ConfigurationThis(string name = null, bool overrideMemberNames = true) {
    const char[] ConfigurationThis = configurationThis(name, overrideMemberNames);
}

string configurationCalls(string name) {
    string fullName = name ~ "Configuration";
    return objCalls(fullName);
}

template ConfigurationCalls(string name) {
    const char[] ConfigurationCalls = configurationCalls(name);
}

/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.configurations.engines.helpers.mixins;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

string ConfigEngineThis(string name = null) {
    string fullName = name ~ "ConfigEngine";
    return objThis(fullName);
}

template ConfigEngineThis(string name = null) {
    const char[] ConfigEngineThis = ConfigEngineThis(name);
}

string ConfigEngineCalls(string name) {
    string fullName = name ~ "ConfigEngine";
    return objCalls(fullName);
}

template ConfigEngineCalls(string name) {
    const char[] ConfigEngineCalls = ConfigEngineCalls(name);
}

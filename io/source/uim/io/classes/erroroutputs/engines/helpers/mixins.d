/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.erroroutputs.engines.helpers.mixins;

import uim.io;

mixin(Version!"test_uim_io");
@safe:

string errorOutputEngineThis(string name = null, bool overrideMemberNames = true) {
    string fullName = name ~ "ErrorOutputEngine";
    return objThis(fullName, overrideMemberNames);
}

template ErrorOutputEngineThis(string name = null, bool overrideMemberNames = true) {
    const char[] ErrorOutputEngineThis = errorOutputEngineThis(name, overrideMemberNames);
}

string errorOutputEngineCalls(string name) {
    string fullName = name ~ "ErrorOutputEngine";
    return objCalls(fullName);
}

template ErrorOutputEngineCalls(string name) {
    const char[] ErrorOutputEngineCalls = errorOutputEngineCalls(name);
}

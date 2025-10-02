/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.classes.error.engines.helpers.mixin_;

import uim.io;

@safe:
string errorOutputEngineThis(string name = null) {
    string fullName = name ~ "ErrorOutputEngine";
    return objThis(fullName);
}

template ErrorOutputEngineThis(string name = null) {
    const char[] ErrorOutputEngineThis = errorOutputEngineThis(name);
}

string errorOutputEngineCalls(string name) {
    string fullName = name ~ "ErrorOutputEngine";
    return objCalls(fullName);
}

template ErrorOutputEngineCalls(string name) {
    const char[] ErrorOutputEngineCalls = errorOutputEngineCalls(name);
}

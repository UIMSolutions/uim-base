/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.classes.outputs.engines.helpers.mixins;

import uim.io;

mixin(Version!"test_uim_io");
@safe:

string outputEngineThis(string name = null) {
    string fullName = name ~ "OutputEngine";
    return objThis(fullName);
}

template OutputEngineThis(string name = null) {
    const char[] OutputEngineThis = outputEngineThis(name);
}

string outputEngineCalls(string name) {
    string fullName = name ~ "OutputEngine";
    return objCalls(fullName);
}

template OutputEngineCalls(string name) {
    const char[] OutputEngineCalls = outputEngineCalls(name);
}

/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.consoles.classes.outputs.engines.formatters.mixins;

mixin(Version!"test_uim_io");

import uim.consoles;
@safe:

string outputEngineFormatterThis(string name = null) {
    string fullName = name ~ "OutputEngineFormatter";
    return objThis(fullName);
}

template OutputEngineFormatterThis(string name = null) {
    const char[] OutputEngineFormatterThis = outputEngineFormatterThis(name);
}

string outputEngineFormatterCalls(string name) {
    string fullName = name ~ "OutputEngineFormatter";
    return objCalls(fullName);
}

template OutputEngineFormatterCalls(string name) {
    const char[] OutputEngineFormatterCalls = outputEngineFormatterCalls(name);
}

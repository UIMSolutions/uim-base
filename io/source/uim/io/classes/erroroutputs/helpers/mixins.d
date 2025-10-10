/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.erroroutputs.helpers.mixins;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

string ErrorOutputThis(string name = null) {
    string fullName = name ~ "ErrorOutput";
    return objThis(fullName);
}

template ErrorOutputThis(string name = null) {
    const char[] ErrorOutputThis = ErrorOutputThis(name);
}

string ErrorOutputCalls(string name) {
    string fullName = name ~ "ErrorOutput";
    return objCalls(fullName);
}

template ErrorOutputCalls(string name) {
    const char[] ErrorOutputCalls = ErrorOutputCalls(name);
}

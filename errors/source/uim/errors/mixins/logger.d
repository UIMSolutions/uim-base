/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.errors.mixins.logger;

import uim.errors;

@safe:
string errorLoggerThis(string name = null) {
    string fullName = name ~ "ErrorLogger";
    return objThis(fullName);
}

template ErrorLoggerThis(string name = null) {
    const char[] ErrorLoggerThis = errorLoggerThis(name);
}

string errorLoggerCalls(string name) {
    string fullName = name ~ "ErrorLogger";
    return objCalls(fullName);
}

template ErrorLoggerCalls(string name) {
    const char[] ErrorLoggerCalls = errorLoggerCalls(name);
}

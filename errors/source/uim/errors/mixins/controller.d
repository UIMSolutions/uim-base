/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.errors.mixins.controller;

import uim.errors;

@safe:
string errorControllerThis(string name = null) {
    string fullName = name ~ "ErrorController";
    return objThis(fullName);
}

template ErrorControllerThis(string name = null) {
    const char[] ErrorControllerThis = errorControllerThis(name);
}

string errorControllerCalls(string name) {
    string fullName = name ~ "ErrorController";
    return objCalls(fullName);
}

template ErrorControllerCalls(string name) {
    const char[] ErrorControllerCalls = errorControllerCalls(name);
}

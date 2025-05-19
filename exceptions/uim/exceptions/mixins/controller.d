/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.exceptions.mixins.controller;

import uim.exceptions;

@safe:
string exceptionControllerThis(string name = null) {
    string fullName = name ~ "ExceptionController";
    return objThis(fullName);
}

template ExceptionControllerThis(string name = null) {
    const char[] ExceptionControllerThis = exceptionControllerThis(name);
}

string exceptionControllerCalls(string name) {
    string fullName = name ~ "ExceptionController";
    return objCalls(fullName);
}

template ExceptionControllerCalls(string name) {
    const char[] ExceptionControllerCalls = exceptionControllerCalls(name);
}

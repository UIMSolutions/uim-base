/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.lists.mixins;

import uim.oop;

mixin(Version!("test_uim_oop"));
@safe:

string listThis(string name = null) {
    string fullName = name ~ "List";
    return objThis(fullName);
}

template ListThis(string name = null) {
    const char[] ListThis = listThis(name);
}

string listCalls(string name) {
    string fullName = name ~ "List";
    return objCalls(fullName);
}

template ListCalls(string name) {
    const char[] ListCalls = listCalls(name);
}

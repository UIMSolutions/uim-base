/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.sets.helpers.mixins;

import uim.oop;

mixin(Version!("test_uim_oop"));
@safe:

string setThis(string name = null) {
    string fullName = name ~ "Set";
    return objThis(fullName);
}

template SetThis(string name = null) {
    const char[] SetThis = setThis(name);
}

string setCalls(string name) {
    string fullName = name ~ "Set";
    return objCalls(fullName);
}

template SetCalls(string name) {
    const char[] SetCalls = setCalls(name);
}

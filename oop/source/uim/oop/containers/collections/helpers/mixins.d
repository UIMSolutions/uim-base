/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.collections.helpers.mixins;

import uim.oop;

mixin(Version!("test_uim_oop"));
@safe:

string collectionThis(string name = null, bool overrideMemberNames = true) {
    string fullName = name ~ "Collection";
    return objThis(fullName, overrideMemberNames);
}

template CollectionThis(string name = null, bool overrideMemberNames = true) {
    const char[] CollectionThis = collectionThis(name, overrideMemberNames);
}

string collectionCalls(string name) {
    string fullName = name ~ "Collection";
    return objCalls(fullName);
}

template CollectionCalls(string name) {
    const char[] CollectionCalls = collectionCalls(name);
}

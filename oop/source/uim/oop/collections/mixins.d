/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.collections.mixins;

import uim.oop;

mixin(Version!("test_uim_oop"));
@safe:

string collectionThis(string name = null) {
    string fullName = name ~ "Collection";
    return objThis(fullName);
}

template CollectionThis(string name = null) {
    const char[] CollectionThis = collectionThis(name);
}

string collectionCalls(string name) {
    string fullName = name ~ "Collection";
    return objCalls(fullName);
}

template CollectionCalls(string name) {
    const char[] CollectionCalls = collectionCalls(name);
}

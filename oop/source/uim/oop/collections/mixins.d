module uim.oop.collections.mixins;

mixin(Version!("test_uim_oop"));

import uim.oop;
@safe:

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

/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.caches.classes.caches.mixins;

mixin(Version!"test_uim_cacheengines");

import uim.caches;

@safe:
string cacheengineThis(string name = null) {
    string fullName = name ~ "CacheEngine";
    return objThis(fullName);
}

template CacheEngineThis(string name = null) {
    const char[] CacheEngineThis = cacheengineThis(name);
}

string cacheengineCalls(string name) {
    string fullName = name ~ "CacheEngine";
    return objCalls(fullName);
}

template CacheEngineCalls(string name) {
    const char[] CacheEngineCalls = cacheengineCalls(name);
}

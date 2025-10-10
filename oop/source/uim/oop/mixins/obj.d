/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.mixins.obj;

mixin(Version!"test_uim_oop");

import uim.oop;
@safe:

string objThis(string name) {
    return `
        this() {
            super("`~ name ~ `");
        }
        this(Json[string] initData) {
            super("`~ name ~ `", initData);
        }
        this(string name, Json[string] initData = null) {
            super(name, initData);
        }
        override string[] memberNames() {
            return [__traits(allMembers, typeof(this))];
        }
    `;
}

template ObjThis(string name) {
    const char[] ObjThis = objThis(name);
}

string objCalls(string name) {
    return `
        auto `~ name ~ `() { return new D` ~ name ~ `(); }
        auto `~ name ~ `(Json[string] initData) { return new D` ~ name ~ `(initData); }
        auto `~ name ~ `(string name, Json[string] initData = null) { return new D` ~ name ~ `(name, initData); }
    `;
}

template ObjCalls(string name) {
    const char[] ObjCalls = objCalls(name);
}

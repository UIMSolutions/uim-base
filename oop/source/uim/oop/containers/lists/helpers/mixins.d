/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.lists.helpers.mixins;

import uim.oop;

mixin(Version!("test_uim_oop"));
@safe:

string listThis(string name = null, bool overrideMemberNames = true) {
    string fullName = name ~ "List";
    return `
        this() {
            super("`~ fullName ~ `");
        }
        this(Json[string] initData) {
            super("`~ fullName ~ `", initData);
        }
        this(string name, Json[string] initData = null) {
            super(name, initData);
        }` ~ 
        (overrideMemberNames ? `override ` : ``) ~ 
        `string[] memberNames() {
            return [__traits(allMembers, typeof(this))];
        }
    `;
}

template ListThis(string name = null, bool overrideMemberNames = true) {
    const char[] ListThis = listThis(name, overrideMemberNames);
}

string listCalls(string name) {
    string fullName = name ~ "List";
    return objCalls(fullName);
}

template ListCalls(string name) {
    const char[] ListCalls = listCalls(name);
}


/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.sets.helpers.mixins;

import uim.oop;

mixin(Version!("test_uim_oop"));
@safe:

string setThis(string name = null, bool overrideMemberNames = true) {
    string fullName = name ~ "Set";
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

template SetThis(string name = null, bool overrideMemberNames = true) {
    const char[] SetThis = setThis(name, overrideMemberNames);
}

string setCalls(string name) {
    string fullName = name ~ "Set";
    return objCalls(fullName);
}

template SetCalls(string name) {
    const char[] SetCalls = setCalls(name);
}

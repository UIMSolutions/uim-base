/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.directories.helpers.mixins;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

string directoryThis(string name = null, bool overrideMemberNames = true) {
    string fullName = name ~ "Directory";
    return objThis(fullName, overrideMemberNames);
}

template DirectoryThis(string name = null, bool overrideMemberNames = true) {
    const char[] DirectoryThis = directoryThis(name, overrideMemberNames);
}

string directoryCalls(string name) {
    string fullName = name ~ "Directory";
    return objCalls(fullName);
}

template DirectoryCalls(string name) {
    const char[] DirectoryCalls = directoryCalls(name);
}

/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.directories.helpers.mixins;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

string directoryThis(string name = null) {
    string fullName = name ~ "Directory";
    return objThis(fullName);
}

template DirectoryThis(string name = null) {
    const char[] DirectoryThis = directoryThis(name);
}

string directoryCalls(string name) {
    string fullName = name ~ "Directory";
    return objCalls(fullName);
}

template DirectoryCalls(string name) {
    const char[] DirectoryCalls = directoryCalls(name);
}

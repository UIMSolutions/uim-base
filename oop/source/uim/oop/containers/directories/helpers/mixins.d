/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.directoriess.helpers.mixins;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

string directoriesThis(string name = null) {
    string fullName = name ~ "Directories";
    return objThis(fullName);
}

template DirectoriesThis(string name = null) {
    const char[] DirectoriesThis = directoriesThis(name);
}

string directoriesCalls(string name) {
    string fullName = name ~ "Directories";
    return objCalls(fullName);
}

template DirectoriesCalls(string name) {
    const char[] DirectoriesCalls = directoriesCalls(name);
}

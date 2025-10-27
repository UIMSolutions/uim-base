/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.consoles.helpers.directory;

mixin(Version!"test_uim_io");

import uim.io;
@safe:


class DConsoleDirectories : DDirectory!DConsole {
}
auto ConsoleDirectories() {
    return new DConsoleDirectories;
}

unittest {
    auto directories = ConsoleDirectories();
    assert(directories !is null);
}

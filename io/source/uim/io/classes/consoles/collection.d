/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.consoles.directory;

import uim.io;
@safe:

mixin(Version!"test_uim_io");

import uim.io;
@safe:


class DConsoleDirectory : DDirectory!DConsole {
}
auto ConsoleDirectory() {
    return new DConsoleDirectory;
}

unittest {
    auto directory = ConsoleDirectory();
    assert(directory !is null);
}

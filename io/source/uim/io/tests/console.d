/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.tests.console;

mixin(Version!"test_uim_io");

import uim.io;
@safe:



bool testConsole(IConsole consoleToTest) {
    assert(consoleToTest !is null, "In testConsole: consoleToTest is null");
    
    return true;
}
/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.consoles.factories.console;

mixin(Version!"test_uim_consoles");

import uim.consoles;
@safe:


class DConsoleFactory : DFactory!DConsole {
}
auto ConsoleFactory() { return DConsoleFactory.factory; }

unittest {
    auto factory = ConsoleFactory();
    assert(factory !is null);
}

/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.consoles.registries.console;

mixin(Version!"test_uim_consoles");

import uim.consoles;
@safe:


class DConsoleRegistry : DObjectRegistry!DConsole {
}

auto ConsoleRegistration() {
    return DConsoleRegistry.registration;
}

unittest {
    auto registry = ConsoleRegistration();
    assert(registry !is null);
}

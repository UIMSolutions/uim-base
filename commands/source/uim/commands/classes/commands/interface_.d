/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.commands.classes.commands.interface_;

mixin(Version!"test_uim_commands");

import uim.commands;
@safe:

interface ICommand : IObject {
    bool execute(Json[string] options = new Json[string], IConsole console = null);
}
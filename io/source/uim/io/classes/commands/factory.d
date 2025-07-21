/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.commands.classes.commands.factory;

mixin(Version!"test_uim_commands");

import uim.commands;
@safe:

class DCommandFactory : DFactory!DCommand {
}
auto CommandFactory() { return DCommandFactory.instance; }
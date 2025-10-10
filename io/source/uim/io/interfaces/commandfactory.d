/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.interfaces.commandfactory;

import uim.io;

@safe:

// An interface for abstracting creation of command and shell instances.
interface IConsoleCommandFactory {
    // The factory method for creating Command  instances.
    IConsoleCommand create(string commandclassname);
}

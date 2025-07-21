/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.consoles.classes.outputs.engines.interfaces;

import uim.consoles;

@safe:

interface IOutputEngine : IObject {
    // Outputs a single or multiple messages or newlines to stdout / stderr.
    IOutputEngine write(string[] messages);
    IOutputEngine write(string message);

    IOutputEngine writeln(uint numberOfLines = 1);
    IOutputEngine writeln(string[] messages, uint numberOfLines = 1);
    IOutputEngine writeln(string message, uint numberOfLines = 1);

    // #region style
    // Gets the current styles offered
    Json style(string name);
    // Gets all the style definitions.
    Json[string] styles();

    // Set style
    IOutputEngine style(string style, STRINGAA definition);
    IOutputEngine style(string style, Json definition);
    IOutputEngine removeStyle(string name);
    // #endregion style

    // #region outputType
    // Get the output type on how formatting tags are treated.
    string outputType();
    // Set the output type on how formatting tags are treated.
    IOutputEngine outputType(string type);
    // #endregion outputType
}

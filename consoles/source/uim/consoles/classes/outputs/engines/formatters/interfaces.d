/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.consoles.classes.outputs.engines.formatters.interfaces;

import uim.consoles;

@safe:

interface IOutputEngineFormatter : IObject {
    // Outputs a single or multiple messages or newlines to stdout / stderr.
    IOutputEngineFormatter write(string[] messages);
    IOutputEngineFormatter write(string message);

    IOutputEngineFormatter writeln(uint numberOfLines = 1);
    IOutputEngineFormatter writeln(string[] messages, uint numberOfLines = 1);
    IOutputEngineFormatter writeln(string message, uint numberOfLines = 1);

    // #region style
    // Gets the current styles offered
    Json style(string name);
    // Gets all the style definitions.
    Json[string] styles();

    // Set style
    IOutputEngineFormatter style(string style, STRINGAA definition);
    IOutputEngineFormatter style(string style, Json definition);
    IOutputEngineFormatter removeStyle(string name);
    // #endregion style

    // #region outputType
    // Get the output type on how formatting tags are treated.
    string outputType();
    // Set the output type on how formatting tags are treated.
    IOutputEngineFormatter outputType(string type);
    // #endregion outputType
}

/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.classes.outputs.formatters.interfaces;

import uim.io;

mixin(Version!"test_uim_io");
@safe:

interface IOutputFormatter : IObject {
    // Outputs a single or multiple messages or newlines to stdout / stderr.
    IOutputFormatter write(string[] messages);
    IOutputFormatter write(string message);

    IOutputFormatter writeln(uint numberOfLines = 1);
    IOutputFormatter writeln(string[] messages, uint numberOfLines = 1);
    IOutputFormatter writeln(string message, uint numberOfLines = 1);

    // #region style
    // Gets the current styles offered
    Json style(string name);
    // Gets all the style definitions.
    Json[string] styles();

    // Set style
    IOutputFormatter style(string style, STRINGAA definition);
    IOutputFormatter style(string style, Json definition);
    IOutputFormatter removeStyle(string name);
    // #endregion style

    // #region outputType
    // Get the output type on how formatting tags are treated.
    string outputType();
    // Set the output type on how formatting tags are treated.
    IOutputFormatter outputType(string type);
    // #endregion outputType
}

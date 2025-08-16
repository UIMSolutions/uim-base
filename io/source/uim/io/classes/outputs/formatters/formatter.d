/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.classes.outputs.engines.formatters.formatter;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

class DOutputFormatter : UIMObject, IOutputFormatter {
  mixin(OutputFormatterThis!());

  override bool initialize(Json[string] initData = null) {
    if (!super.initialize(initData)) {
      return false;
    }
    return true;
  }

    // Outputs a single or multiple messages or newlines to stdout / stderr.
    IOutputFormatter write(string[] messages);
    IOutputFormatter write(string message);

    IOutputFormatter writeln(uint numberOfLines = 1);
    IOutputFormatter writeln(string[] messages, uint numberOfLines = 1);
    IOutputFormatter writeln(string message, uint numberOfLines = 1);

    // #region styles
    // Gets the current styles offered
    protected IOutputStyle[string] _styles;

    IOutputStyle style(string name) {
      return (name in _styles) ? _styles[name] : null;
    }

    IOutputStyle style(string name) {
      return (name in _styles) ? _styles[name] : null;
    }

    // Gets all the style definitions.
    IOutputStyle[string] styles() {
      return _styles;
    }

    // Set style
    IOutputFormatter style(string style, STRINGAA definition);
    IOutputFormatter style(string style, Json definition);
    IOutputFormatter removeStyle(string name);
    // #endregion styles

    // #region outputType
    // Get the output type on how formatting tags are treated.
    string outputType();
    // Set the output type on how formatting tags are treated.
    IOutputFormatter outputType(string type);
    // #endregion outputType

}
mixin(OutputFormatterCalls!());

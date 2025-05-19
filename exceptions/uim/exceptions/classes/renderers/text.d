/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.exceptions.classes.renderers.text;

mixin(Version!("test_uim_exceptions"));

import uim.exceptions;
@safe:

/**
 * Plain text exception rendering with a stack trace.
 * Useful in CI or plain text environments.
 */
class DTextExceptionRenderer : DExceptionRenderer {
  mixin(ExceptionRendererThis!("Text"));

  private IException _exception;

  this(IException exception) {
    _exception = exception;
  }

  // Render an exception into a plain text message.
  string render() {
    return "%s : %s on line %s of %s\nTrace:\n%s".format(
      _exception.message(),
      _exception.file(),
      _exception.line()
    );
  }

  // Write output to stdout.
  IExceptionRenderer write(string outputText) {
    writeln(outputText);
    return this;
  }
}
mixin(ExceptionRendererCalls!("Text"));

/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.errors.classes.renderers.console;

mixin(Version!("test_uim_errors"));

import uim.errors;
@safe:

/*
 * Plain text error rendering with a stack trace.
 * Writes to STDERR via a UIM\Console\OutputConsole instance for console environments
 */
class DConsoleErrorRenderer : UIMErrorRenderer { 
  mixin(ErrorRendererThis!("Console"));

  override bool initialize(Json[string] initData = null) {
    if (!super.initialize(initData)) {
      return false;
    }

    // `stderr` - The OutputConsole instance to use. Defaults to `D://stderr`
    // TODO _output = configuration.getEntry("stderr", new DOutput("d://stderr"));
    // `trace` - Whether or not stacktraces should be output.       
    _showTrace = configuration.getBooleanEntry("trace");

    return true;
  }

  // #region trace
  protected bool _showTrace = false;
  bool showTrace() {
    return _showTrace;
  }
  IErrorRenderer showTrace(bool value) {
    _showTrace = value;
    return this;
  }
  // #endregion trace

  // TODO protected DOutput _output;

  override IErrorRenderer write(string outputText) {
    writeln(outputText);
    return this;
  }

  override string render(IError error, bool shouldDebug) {
    return "<error>%s: %s . %s</error> on line %s of %s%s"
      .format(
        error.loglabel(),
        error.loglevel(),
        error.message(),
        error.line() ? error.line() : "",
        error.fileName() ? error.fileName() : "",
        showTrace ? "\n<info>Stack Trace:</info>\n\n" ~ error.traceAsString() : ""
      ); 
  }
}

/* unittest {
  auto renderer = new DConsoleErrorRenderer();
  // assert(is(typeof(renderer) == IErrorRenderer));
  /* assert(renderer is UIMErrorRenderer);
  assert(renderer is DConsoleErrorRenderer); */

  /* auto error = new UIMError()
    .message("This is a test error")
    .code("TEST_ERROR")
    .fileName(__FILE__)
    .lineNumber(33); */

  /* assert(renderer.render(new UIMError("Test Error", "TEST_ERROR", "This is a test error", __FILE__, __LINE__), true) == "<error>Test Error: TEST_ERROR . This is a test error</error> on line 33 of errors/uim/errors/classes/renderers/consoles/error.d\n<info>Stack Trace:</info>\n\n");
  assert(renderer.render(new UIMError("Test Error", "TEST_ERROR", "This is a test error", __FILE__, __LINE__), false) == "<error>Test Error: TEST_ERROR . This is a test error</error> on line 33 of errors/uim/errors/classes/renderers/consoles/error.d");
  assert(renderer.showTrace(true) is renderer);
  assert(renderer.showTrace() == true);
  assert(renderer.showTrace(false) is renderer);
  assert(renderer.showTrace() == false); * /
} */

/* 
/**
 * Plain text error rendering with a stack trace.
 *
 * Useful in CI or plain text environments.
 * /
class DConsoleErrorRenderer : UIMErrorRenderer {
    mixin(ErrorRendererThis!("Console"));

    private Throwable _error;

    /* private DOutput _output; * /

    private bool _trace;

    /* this(Throwable errorToRender, IServerRequest serverRequest, Json[string] errorHandlingData) {
        _error = error;
        // TODO this.output = configuration.getEntry("stderr") ?? new DOutput("d://stderr");
        _trace = configuration..getBooleanEntry("trace", true);
    } * /

    // Render an error into a plain text message.
    string render() {
/*         auto errors = [_error];
        auto previous = _error.getPrevious();
        while (!previous.isNull) {
            errors ~= previous;
            previous = previous.getPrevious();
        } * /

        string[] results;
/*         foreach (index, error; errors) {
            parent = index > 0 ? errors[index - 1] : null;
            results = chain(result, this.renderError(error, parent));
        } * /
        return results.join("\n");
    }

    // Render an individual error
    protected Json[string] renderError(UIMError error, UIMError parentError) {
        /* auto result = [
            "<error>%s[%s] %s</error> in %s on line %s"
            .format(
                parent ? "Caused by " : "",
                error.classname,
                error.message(),
                error.getFile(),
                error.getLine()
            ),
        ]; * /

        // auto debugValue = configuration.getEntry("debug");
/*         if (debugValue && cast(UIMError) errorToRender) {
            auto attributes = errorToRender.getAttributes();
            if (attributes) {
                result ~= "";
                result ~= "<info>Error Attributes</info>";
                result ~= "";
                result ~= var_export_(errorToRender.getAttributes(), true);
            }
        } * /
/*         if (_trace) {
            auto stacktrace = Debugger.getUniqueFrames(errorToRender, parentError);
            result ~= "";
            result ~= "<info>Stack Trace:</info>";
            result ~= "";
            result ~= Debugger.formatTrace(stacktrace, ["format": "text"]);
            result ~= "";
        } * /
        // return result;
        return null; 
    }

    /**
     * Write output to the output stream
     * Params:
     * \Psr\Http\Message\IResponse|string aoutput The output to print.
     * /
    // TODO void write(IResponse aoutput) {
    void write(string outputText) {
        // _output.write(outputText);
    }
}
mixin(ErrorRendererCalls!("Console"));

*/ 
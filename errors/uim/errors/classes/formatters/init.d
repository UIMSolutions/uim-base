module uim.errors.classes.formatters.init;

import uim.errors;

@safe:

static this() {
  ErrorFormatterFactory.set("html", (Json[string] options = null) @safe {
    return new DHtmlErrorFormatter(options);
  });
}

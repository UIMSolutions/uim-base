module uim.errors.classes.debuggers.formatters.json;

mixin(Version!("test_uim_errors"));

import uim.errors;

@safe:

class DJsonErrorFormatter : UIMErrorFormatter {
  mixin(ErrorFormatterThis!("Json"));
}
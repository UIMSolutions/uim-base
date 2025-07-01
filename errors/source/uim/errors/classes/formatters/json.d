module uim.errors.classes.formatters.json;

mixin(Version!("test_uim_errors"));

import uim.errors;

@safe:

class DJsonErrorFormatter : DErrorFormatter {
  mixin(ErrorFormatterThis!("Json"));
}
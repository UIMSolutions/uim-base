module uim.errors.classes.formatters.yaml;

mixin(Version!("test_uim_errors"));

import uim.errors;

@safe:

class DYamlErrorFormatter : DErrorFormatter {
  mixin(ErrorFormatterThis!("Yaml"));
}
mixin(ErrorFormatterCalls!("Yaml"));

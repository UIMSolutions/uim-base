module uim.errors.classes.formatters.xml;

mixin(Version!("test_uim_errors"));

import uim.errors;

@safe:

class DXmlErrorFormatter : UIMErrorFormatter {
  mixin(ErrorFormatterThis!("Xml"));
}
mixin(ErrorFormatterCalls!("Xml"));

module uim.errors.tests.formatter;

import uim.errors;

@safe:

mixin(Version!"test_uim_errors");

import uim.errors;
@safe:


bool testErrorFormatter(IErrorFormatter formatter) {
  assert(formatter !is null, "Formatter is null");
  return true;
}

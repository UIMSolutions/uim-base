module uim.errors.tests.logger;

import uim.errors;

@safe:

mixin(Version!"test_uim_errors");

import uim.errors;
@safe:


bool testErrorLogger(IErrorLogger logger) {
  assert(logger !is null, "Logger is null");
  return true;
}

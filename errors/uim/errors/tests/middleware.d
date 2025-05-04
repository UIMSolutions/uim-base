module uim.errors.tests.middleware;

import uim.errors;

@safe:

mixin(Version!"test_uim_errors");

import uim.errors;
@safe:


bool testErrorMiddleware(IErrorMiddleware middleware) {
  assert(middleware !is null, "Middleware is null");
  return true;
}

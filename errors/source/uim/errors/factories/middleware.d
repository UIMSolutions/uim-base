module uim.errors.factories.middleware;

mixin(Version!"test_uim_errors");

import uim.errors;
@safe:

class DErrorMiddlewareFactory : DFactory!DErrorMiddleware {}
auto ErrorMiddlewareFactory() { return DErrorMiddlewareFactory.factory; }
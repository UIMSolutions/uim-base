module uim.errors.factories.middleware;

mixin(Version!"test_uim_errors");

import uim.errors;
@safe:

class UIMErrorMiddlewareFactory : DFactory!UIMErrorMiddleware {}
auto ErrorMiddlewareFactory() { return UIMErrorMiddlewareFactory.factory; }
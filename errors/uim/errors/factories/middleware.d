module uim.errors.factories.middleware;

mixin(Version!"test_uim_exceptions");

import uim.exceptions;
@safe:

class DExceptionMiddlewareFactory : DFactory!DExceptionMiddleware {}
auto ExceptionMiddlewareFactory() { return DExceptionMiddlewareFactory.factory; }
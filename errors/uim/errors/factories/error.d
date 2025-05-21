module uim.errors.factories.error;

mixin(Version!"test_uim_exceptions");

import uim.exceptions;
@safe:

class DExceptionFactory : DFactory!DException {}
auto ExceptionFactory() { return DExceptionFactory.factory; }
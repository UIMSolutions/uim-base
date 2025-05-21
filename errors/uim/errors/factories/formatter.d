module uim.errors.factories.formatter;

mixin(Version!"test_uim_exceptions");

import uim.exceptions;
@safe:

class DExceptionFormaterFactory : DFactory!DExceptionFormater {}
auto ExceptionFormaterFactory() { return DExceptionFormaterFactory.factory; }
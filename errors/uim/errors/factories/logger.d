module uim.errors.factories.logger;

mixin(Version!"test_uim_errors");

import uim.errors;
@safe:

class DErrorLoggerFactory : DFactory!DErrorLogger {}
auto ErrorLoggerFactory() { return DErrorLoggerFactory.factory; }
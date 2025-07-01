module uim.errors.factories.error;

mixin(Version!"test_uim_errors");

import uim.errors;
@safe:

class DErrorFactory : DFactory!DError {}
auto ErrorFactory() { return DErrorFactory.factory; }
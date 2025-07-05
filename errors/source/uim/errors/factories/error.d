module uim.errors.factories.error;

mixin(Version!"test_uim_errors");

import uim.errors;
@safe:

class UIMErrorFactory : DFactory!UIMError {}
auto ErrorFactory() { return UIMErrorFactory.factory; }
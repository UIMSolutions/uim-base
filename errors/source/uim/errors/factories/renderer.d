module uim.errors.factories.renderer;

mixin(Version!"test_uim_errors");

import uim.errors;
@safe:

class UIMErrorRendererFactory : DFactory!UIMErrorRenderer {}
auto ErrorRendererFactory() { return UIMErrorRendererFactory.factory; }
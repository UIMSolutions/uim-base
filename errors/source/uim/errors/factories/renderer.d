module uim.errors.factories.renderer;

mixin(Version!"test_uim_errors");

import uim.errors;
@safe:

class DErrorRendererFactory : DFactory!DErrorRenderer {}
auto ErrorRendererFactory() { return DErrorRendererFactory.factory; }
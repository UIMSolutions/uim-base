module uim.errors.factories.renderer;

mixin(Version!"test_uim_exceptions");

import uim.exceptions;
@safe:

class DExceptionRendererFactory : DFactory!DExceptionRenderer {}
auto ExceptionRendererFactory() { return DExceptionRendererFactory.factory; }
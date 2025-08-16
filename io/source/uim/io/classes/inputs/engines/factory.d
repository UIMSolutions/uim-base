module uim.io.classes.inputs.engines.factory;

mixin(Version!"test_uim_io");

import uim.io;
@safe:


class DInputFactory : DFactory!DInput{}

auto InputFormatterFactoryInputFactory() {
    return DInputFactory.instance;
}

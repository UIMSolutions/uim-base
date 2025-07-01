module uim.errors.factories.formatter;

mixin(Version!"test_uim_errors");

import uim.errors;

@safe:

class DErrorFormatterFactory : DFactory!DErrorFormatter {
}

auto ErrorFormatterFactory() {
    return DErrorFormatterFactory.factory;
}

auto ErrorFormatterFactory(string key) {
    return ErrorFormatterFactory.create(key);   
}

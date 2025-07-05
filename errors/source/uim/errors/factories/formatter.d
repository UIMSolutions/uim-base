module uim.errors.factories.formatter;

mixin(Version!"test_uim_errors");

import uim.errors;

@safe:

class UIMErrorFormatterFactory : DFactory!UIMErrorFormatter {
}

auto ErrorFormatterFactory() {
    return UIMErrorFormatterFactory.factory;
}

auto ErrorFormatterFactory(string key) {
    return ErrorFormatterFactory.create(key);   
}

/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.errors.factories.formatter;

mixin(Version!"test_uim_errors");

import uim.errors;

@safe:

class UIMErrorFormatterFactory : DFactory!UIMErrorFormatter {
}

auto ErrorFormatterFactory() {
    return UIMErrorFormatterFactory.instance;
}

auto ErrorFormatterFactory(string key) {
    return ErrorFormatterFactory.create(key);   
}

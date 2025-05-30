/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.errors.classes.errors.registry;

mixin(Version!("test_uim_errors"));

import uim.errors;
@safe:

class DErrorRegistry : DObjectRegistry!DError {
}

auto ErrorRegistry() {
    return DErrorRegistry.registration;
}

unittest {
    auto registry = ErrorRegistry();
    assert(registry !is null);
    assert(registry is ErrorRegistry());
}
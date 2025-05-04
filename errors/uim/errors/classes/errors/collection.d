/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.errors.classes.errors.collection;

mixin(Version!("test_uim_errors"));

import uim.errors;
@safe:


class DErrorCollection : DCollection!DError {   
}

auto ErrorCollection() {
    return new DErrorCollection;
}

unittest {
    auto collection = ErrorCollection();
    assert(collection !is null);
    // assert(collection is DErrorCollection);
} 
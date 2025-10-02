/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.classes.error.engines.helpers.collection;

import uim.io;
@safe:

mixin(Version!"test_uim_io");

import uim.io;
@safe:


class DErrorOutputEngineCollection : DCollection!DErrorOutputEngine {
    mixin(CollectionThis!("ErrorOutputEngine"));
}
mixin(CollectionCalls!("ErrorOutputEngine"));

unittest {
    auto collection = ErrorOutputEngineCollection();
    assert(collection !is null);

    assert(testCollection(collection, "ErrorOutputEngine"), "ErrorOutputEngineCollection failed");  
}
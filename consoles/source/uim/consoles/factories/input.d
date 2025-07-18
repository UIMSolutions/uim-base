/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.consoles.factories.input;

mixin(Version!"test_uim_consoles");

import uim.consoles;
@safe:


class DInputFactory : DFactory!DInput{}

auto InputFactory() {
    return DInputFactory.factory;
}

unittest {
    assert(InputFactory);
    assert(InputFactory.create("standard").name == "StandardInput");
    assert(InputFactory.create("file").name == "FileInput");
    assert(InputFactory.create("rest").name == "RestInput");
}



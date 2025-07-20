/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.consoles.classes.outputs.engines.formatters.factory;

mixin(Version!"test_uim_consoles");

import uim.consoles;
@safe:


class DOutputEngineFormatterFactory : DFactory!DOutputEngineFormatter{}

auto OutputFactory() {
    return DOutputFactory.factory;
}

unittest {
    assert(OutputFactory);
    assert(OutputFactory.create("standard").name == "StandardOutput");
    assert(OutputFactory.create("file").name == "FileOutput");
    assert(OutputFactory.create("rest").name == "RestOutput");
}
 
/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.classes.outputs.engines.tests;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

bool testOutput(IOutputEngine output) {
    assert(output !is null, "In testOutput: output is null");
    
    return true;
}
/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.classes.outputs.formatters.helpers.tests;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

bool testOutputFormatter(DOutputFormatter formatter) {
    // Test the formatter's initialization
    if (!formatter.initialize()) {
        return false;
    }

    // Additional tests can be added here as needed
    return true;
}
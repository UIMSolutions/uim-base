/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.tests.configuration;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

// Test function for IConfiguration
bool testConfiguration(IConfiguration configuration) {
/*     writeln("Testing configuration: ", configuration.name);

    writeln("Init Entries...");
    configuration.entries([
        "a": Json("A"),
        "b": Json("B"),
        "1": Json(1),
        "1.1": Json(1.1),
        "true": Json(true),
        "false": Json(false),
        "null": Json(null)
    ]);

    // writeln("Entries: ", config.entries.toString());
    assert(config.entries.length == 7, config.name);
    assert(config.entryKeys.length == 7, config.name);
    assert(config.entryValues.length == 7, config.name);

    // writeln("Reading 1... ", config.entries.toString());
    assert(config.getStringEntry("a") == "A", config.name);
    writeln("Reading 2... ", config.entries.toString());
    assert(config.getStringEntry("b") == "B", config.name); */

    return true;
}
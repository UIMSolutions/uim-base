/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.tests.constraints.contents.content;

import uim.io;
@safe:

mixin(Version!"test_uim_io");

import uim.io;
@safe:



// Base constraint for content constraints
abstract class DContentsBase : DConstraint {
    protected string _content;
    protected string _output;

    // TODO 
    this(string[] contents, string outputType) {
        // _content = contents.join(D_EOL);
        _output = outputType;
    }
}

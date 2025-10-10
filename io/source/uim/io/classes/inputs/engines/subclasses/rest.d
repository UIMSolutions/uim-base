/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.classes.inputs.engines.subclasses.rest;

import uim.io;
@safe:

mixin(Version!"test_uim_io");

import uim.io;
@safe:


// Object wrapper for interacting with stdin
class DRestInput : DInput {
  mixin(InputThis!("Rest"));
}

mixin(InputCalls!("Rest"));

unittest {
  auto input = RestInput;
  assert(testInput(input));
}

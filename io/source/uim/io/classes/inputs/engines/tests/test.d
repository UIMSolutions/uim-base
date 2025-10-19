/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.inputs.engines.tests.test;

mixin(Version!"test_uim_io");

import uim.io;

@safe:

bool testInputEngine(DInputEngine engine, string typeName) {
  assert(engine !is null, typeName ~ " engine is null");
  assert(typeName !is null && typeName.length > 0, "Type name is null or empty");
  assert(engine.name == typeName, typeName ~ " engine type name mismatch");

  return true;
}

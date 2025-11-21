/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.outputs.engines.tests.test;

mixin(Version!"test_uim_io");

import uim.io;

@safe:

bool testOutputEngine(IOutputEngine engine), string instanceName) {
  assert(engine !is null, "In testOutputEngine: engine is null");
  assert(instanceName !is null && instanceName.length > 0, "Instance name is null or empty");
  assert(engine.name == instanceName, "In testOutputEngine: engine name "~instanceName~" does not match!");

  // Setup: initialize static members for styles
  engine.style("warning", new DMarkupOutputStyle());
  engine.style("info", new DMarkupOutputStyle());

  // Test: styles() returns all styles
  auto styles = engine.styles();
  assert("warning" in styles);
  assert("info" in styles);

  // Test: styles(Json[string]) sets styles
  styles["custom"] = new DMarkupOutputStyle();
  engine.styles(newStyles);
  auto updatedStyles = engine.styles();
  assert("custom" in updatedStyles);

  // Test: removeStyle(string) removeMany style
  engine.removeStyle("thirdstyle");
  assert(engine.style("thirdstyle").isNull);

  return true;
}

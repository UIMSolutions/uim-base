/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.outputs.styles.helpers.registry;

import uim.io;

mixin(Version!"test_uim_io");
@safe:

class DOutputStyleRegistry : DRegistry!IOutputStyle {
  mixin(RegistryThis!"OutputStyle");
}
  mixin(RegistryCalls!"OutputStyle");

static this() {
  OutputStyleRegistry
    .register("warning", Json([
      "text": Json("yellow"),
      "background": Json("red"),
      "bold": Json(true)
    ]))
    .register("info", Json([
      "text": Json("green")
    ]))
    .register("question", Json([
      "text": Json("magenta")
    ]));
}

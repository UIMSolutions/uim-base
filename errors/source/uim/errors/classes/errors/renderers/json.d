/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.errors.classes.errors.renderers.json;

mixin(Version!("test_uim_errors"));

import uim.errors;
@safe:

class DJsonErrorRenderer : UIMErrorRenderer { 
  mixin(ErrorRendererThis!("Json"));
}
mixin(ErrorRendererCalls!("Json"));

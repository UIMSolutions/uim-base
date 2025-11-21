/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.consoles.helpers.functions;

mixin(Version!"test_uim_io");

import uim.io;

@safe:

bool isConsole(Object obj) {
  return obj is null
    ? false : cast(IConsole)obj !is null;
}

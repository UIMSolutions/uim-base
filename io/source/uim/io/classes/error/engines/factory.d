/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.classes.error.engines.factory;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

class DErrorOutputFactory : DFactory!DErrorOutput {
}

auto ErrorOutputFactory() {
  return DErrorOutputFactory.instance;
}

unittest {
  assert(ErrorOutputFactory);
  assert(ErrorOutputFactory.create("standard").name == "StandardErrorOutput");
  assert(ErrorOutputFactory.create("file").name == "FileErrorOutput");
  assert(ErrorOutputFactory.create("rest").name == "RestErrorOutput");
}

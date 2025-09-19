/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.formatters.collection;

mixin(Version!"test_uim_oop");

import uim.oop;
@safe:


class DFormatterCollection : DCollection!DFormatter {   
}
auto FormatterCollection() { return new DFormatterCollection; } 

unittest {
  /* assert(FormatterCollection);

  auto collection = FormatterCollection; */
}
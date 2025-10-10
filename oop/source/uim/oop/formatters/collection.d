/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.formatters.collection;

mixin(Version!"test_uim_oop");

import uim.oop;

@safe:

/** 
  * Formatter for collections of type `IFormatter`.
  *
  * This formatter provides methods to format collections of `IFormatter` objects.
  */
class DFormatterCollection : DCollection!IFormatter {
  mixin(CollectionThis!("Formatter"));
}
/// 
unittest {
  // Test with empty collection
  auto emptyFormatter = new DFormatterCollection();
  assert(emptyFormatter.isEmpty);

  // Test with single formatter
  auto singleFormatter = new DFormatterCollection();
  singleFormatter.add(new Formatter("Single"));
  assert(!singleFormatter.isEmpty);
  assert(singleFormatter.size == 1);
  assert(singleFormatter.first.name == "Single");

  // Test with multiple formatters
  auto multiFormatter = new DFormatterCollection();
  multiFormatter.add(new Formatter("First"));
  multiFormatter.add(new Formatter("Second"));
  assert(multiFormatter.size == 2);
  assert(multiFormatter.last.name == "Second");
}

mixin(CollectionCalls!("Formatter"));
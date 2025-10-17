/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.formatters.helpers.dictionary;

mixin(Version!"test_uim_oop");

import uim.oop;

@safe:

/** 
  * Formatter for directorys of type `IFormatter`.
  *
  * This formatter provides methods to format directorys of `IFormatter` objects.
  */
class DFormatterDirectory : DDirectory!IFormatter {
  mixin(DirectoryThis!("Formatter"));
}
/// 
unittest {
  // Test with empty directory
  auto emptyFormatter = new DFormatterDirectory();
  assert(emptyFormatter.isEmpty);

  // Test with single formatter
  auto singleFormatter = new DFormatterDirectory();
  singleFormatter.add(new Formatter("Single"));
  assert(!singleFormatter.isEmpty);
  assert(singleFormatter.size == 1);
  assert(singleFormatter.first.name == "Single");

  // Test with multiple formatters
  auto multiFormatter = new DFormatterDirectory();
  multiFormatter.add(new Formatter("First"));
  multiFormatter.add(new Formatter("Second"));
  assert(multiFormatter.size == 2);
  assert(multiFormatter.last.name == "Second");
}

mixin(DirectoryCalls!("Formatter"));
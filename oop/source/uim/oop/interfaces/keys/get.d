/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.interfaces.keys.get;

mixin(Version!"test_uim_oop");

import uim.oop;
@safe:

interface IGetKeys(T) {
  // #region get
  // Gets the entire collection as a map of paths to items.
  T[string] items(string[][] keys);

  // Gets a specific item from the collection.
  T item(string key);
  // #endregion get
}


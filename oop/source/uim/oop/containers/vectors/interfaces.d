/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.vectors.interfaces;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

interface IVector(V) : IList!V {
  /* bool add(V item);
  bool removeValue(V item);
  V get(size_t index);
  bool set(size_t index, V item);
  size_t indexOf(V item); */
}
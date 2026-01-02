/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.maps.interfaces;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

/// Interface for map containers.
interface IMap(K, V) : IContainer, IKeys!(K, V), IValues!(K, V) {
  // #region entries
  V[K] entries();
  void entries(V[K] newEntries);

  // #region has
  bool hasAllEntry(K, V)(V[K] checkEntries);

  bool hasAnyEntry(K, V)(V[K] checkEntries);

  bool hasEntry(K, V)(K key, V value);
  // #endregion has
  // #endregion entries

  V[] values(K[] keys = null);
  V opCall(string key);
  void opCall(string key, V value);
}

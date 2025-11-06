/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.maps.interfaces;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

interface IMap(K, V) : IKeys!(K, V), IContainer {
  // #region has methods
  bool hasAllValue(V[] values);
  bool hasAnyValue(V[] values);
  bool hasValue(V value);
  // #endregion has methods

  // #region get methods
  // #region values
  V[] values();
  V[] values(K[][] path);
  V[] values(K[] keys);
  // #endregion values

  // #region value
  V value(K[] path);
  V value(K key);
  // #endregion value
  // #endregion get methods

  bool removeAllValue(V[] values);
  bool removeAnyValue(V[] values);
  bool removeValue(V value);
}

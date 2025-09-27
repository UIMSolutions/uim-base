/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.caches.classes.caches.collection;

mixin(Version!"test_uim_caches");

import uim.caches;
@safe:


class DCacheCollection : DCollection!DCache {
  mixin(CollectionThis!("Cache"));
}
auto CacheCollection() { return new DCacheCollection; } 

unittest {
  assert(CacheCollection);

  auto collection = CacheCollection;
}

/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.caches.classes.engines.factory;

import uim.caches;

mixin(Version!"test_uim_caches");
@safe:

class DCacheEngineFactory : DFactory!ICacheEngine {
    mixin(FactoryThis!("CacheEngine"));
}
mixin(FactoryCalls!("CacheEngine"));

unittest {
  auto factory = new DCacheEngineFactory();
  assert(factory !is null);

  testFactory(factory, "CacheEngine");
}
/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt redis.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.configurations.engines.subclasses.redis;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

class DRedisConfigEngine : DConfigEngine {
  mixin(ConfigEngineThis!("Redis"));
}

mixin(ConfigEngineCalls!("Redis"));

unittest {
  auto engine = new DRedisConfigEngine();
  assert(testConfigEngine(engine, "Redis"), "Test of RedisConfigEngine failed!");
}

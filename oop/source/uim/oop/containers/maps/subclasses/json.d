/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.maps.subclasses.json;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

class DJsonMap : UIMMap!(string, Json)  {
  this() {}
}
auto JsonMap() { return new DJsonMap; }

unittest {
  auto jmap = JsonMap;

  jmap["key1"] = Json("value1");
  jmap["key2"] = Json("value2");
  // assert(jmap.length == 2);
/*   assert(jmap["key1"].toString == "value1");
  assert(map["key2"].toString == "value2");
 */
  /*map.removeMany(["key1"]);
  assert(map.length == 1);
/*   assert(!map.containsKey("key1"));
  assert(map.containsKey("key2")); */

  _entries.values.array
}
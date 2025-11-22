/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.configurations.helpers.list;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

class DConfigurationList : UIMList!IConfiguration {
  mixin(ListThis!("Configuration"));
}

mixin(ListCalls!("Configuration"));

unittest {
  auto list = new DConfigurationList();
  assert(testList(new DConfigurationList, "ConfigurationList"), "Test of DConfigurationList failed!");
}
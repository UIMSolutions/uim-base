/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt xml.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.configurations.engines.subclasses.xml;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

class DXmlConfigEngine : DConfigEngine {
    mixin(ConfigEngineThis!("Xml"));  

      override IConfigEngine clone() {
    return new DXmlConfigEngine();
  }  
}
mixin(ConfigEngineCalls!("Xml")); 

unittest {
  auto engine = new DXmlConfigEngine();
  assert(testConfigEngine(engine, "Xml"), "Test of DXmlConfigEngine failed!");
}


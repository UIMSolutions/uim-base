/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt yaml.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.configurations.engines.subclasses.yaml;

mixin(Version!"test_uim_oop");

import uim.oop;
@safe:

class DYamlConfigEngine : DConfigEngine {
    mixin(ConfigEngineThis!("Yaml"));    
}
mixin(ConfigEngineCalls!("Yaml"));    

/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.interfaces.values.all;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

interface IValues(K = string, V = UIMObject) : IHasValues!(K, V), IGetValues!(K, V), IChangeValues!(K, V), IRemoveValues!(K, V) {
}

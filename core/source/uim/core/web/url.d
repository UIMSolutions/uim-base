/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.core.web.url;

import uim.core;

@safe:

unittest {
  writeln("-----  ", __MODULE__, "\t  -----");
}

string correctUrl(string url) {
    return url.endsWith("/") 
        ? url   
        : url ~"/";
}
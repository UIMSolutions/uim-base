/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.parsers.registry;

import uim.oop;
@safe:

class DParserRegistry : DRegistry!DParser {
}
auto ParserRegistry() { return DParserRegistry.instance; }